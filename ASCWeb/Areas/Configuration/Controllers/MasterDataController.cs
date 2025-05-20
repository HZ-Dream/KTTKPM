using ASC.Business.Interfaces;
using ASC.Model.Models;
using ASC.Ultilities;
using ASCWeb.Areas.Configuration.Models;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using OfficeOpenXml;

namespace ASCWeb.Areas.Configuration.Controllers
{
    [Area("Configuration")]
    [Authorize(Roles = "Admin")]
    public class MasterDataController : Controller
    {
        private readonly IMasterDataOperations _masterData;
        private readonly IMapper _mapper;

        public MasterDataController(IMasterDataOperations masterData, IMapper mapper)
        {
            _masterData = masterData;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<IActionResult> MasterKeys()
        {
            var masterKeys = await _masterData.GetAllMasterKeysAsync();
            var masterKeysViewModel = _mapper.Map<List<MasterDataKey>, List<MasterDataKeyViewModel>> (masterKeys);

            HttpContext.Session.SetSession("MasterKeys", masterKeysViewModel);
            return View(new MasterKeysViewModel
            {
                MasterKeys = masterKeysViewModel == null ? null : masterKeysViewModel.ToList(),
                IsEdit = false
            });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> MasterKeys(MasterKeysViewModel masterKeys)
        {
            masterKeys.MasterKeys = HttpContext.Session.GetSession<List<MasterDataKeyViewModel>>("MasterKeys");
            if (!ModelState.IsValid) {
                return View(masterKeys);
            }

            var masterKey = _mapper.Map<MasterDataKeyViewModel, MasterDataKey>(masterKeys.MasterKeyInContext);
            if (masterKeys.IsEdit) {
                await _masterData.UpdateMasterKeyAsync(masterKeys.MasterKeyInContext.PartitionKey, masterKey);
            }
            else
            {
                masterKey.RowKey = Guid.NewGuid().ToString();
                masterKey.PartitionKey = masterKey.Name;
                masterKey.CreatedBy = HttpContext.User.GetCurrentUserDetails().Name;
                await _masterData.InsertMasterKeyAsync(masterKey);
            }

            return RedirectToAction("MasterKeys");
        }

        [HttpGet]
        public async Task<IActionResult> MasterValues()
        {
            ViewBag.MasterKeys = await _masterData.GetAllMasterKeysAsync();
            return View(new MasterValuesViewModel
            {
                MasterValues = new List<MasterDataValueViewModel>(),
                IsEdit = false
            });
        }

        [HttpGet]
        public async Task<IActionResult> MasterValuesByKey(string key)
        {
            return Json(new { data = await _masterData.GetAllMasterValuesByKeyAsync(key) });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> MasterValues(MasterValuesViewModel model)
        {
            if (model == null || model.MasterValueInContext == null)
            {
                return Json(new { success = false, message = "Model hoặc MasterValueInContext là null" });
            }

            if (!ModelState.IsValid)
            {
                var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage);
                Console.WriteLine("ModelState Errors: " + string.Join(", ", errors));
                return Json(new { success = false, message = "ModelState không hợp lệ", errors });
            }

            var masterDataValue = _mapper.Map<MasterDataValueViewModel, MasterDataValue>(model.MasterValueInContext);
            if (model.IsEdit)
            {
                await _masterData.UpdateMasterValueAsync(masterDataValue.PartitionKey, masterDataValue.RowKey, masterDataValue);
            }
            else
            {
                masterDataValue.RowKey = Guid.NewGuid().ToString();
                masterDataValue.CreatedBy = HttpContext.User.GetCurrentUserDetails().Name;
                await _masterData.InsertMasterValueAsync(masterDataValue);
            }
            return RedirectToAction("MasterValues");
        }

        // ExcelPackage.License.SetNonCommercialPersonal("HoaiDream");
        public async Task<List<MasterDataValue>> ParseMasterDataExcel(IFormFile excelFile)
        {
            var masterValueList = new List<MasterDataValue>();
            var newKeysList = new List<MasterDataKey>();

            // Lấy tất cả master keys hiện có
            var existingKeys = await _masterData.GetAllMasterKeysAsync();

            // Dictionary để map giữa tên key và rowKey
            var nameToRowKeyMap = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);

            // Map tên key với rowKey
            foreach (var key in existingKeys)
            {
                nameToRowKeyMap[key.Name] = key.RowKey;
            }

            ExcelPackage.License.SetNonCommercialPersonal("HoaiDream");
            using (var memoryStream = new MemoryStream())
            {
                await excelFile.CopyToAsync(memoryStream);
                memoryStream.Position = 0;
                using (var package = new ExcelPackage(memoryStream))
                {
                    var worksheet = package.Workbook.Worksheets[0];
                    int rowCount = worksheet.Dimension?.Rows ?? 0;

                    if (rowCount < 2) return masterValueList; // Không có dữ liệu

                    for (int row = 2; row <= rowCount; row++)
                    {
                        var keyName = worksheet.Cells[row, 1]?.Value?.ToString()?.Trim();
                        var valueName = worksheet.Cells[row, 2]?.Value?.ToString()?.Trim();
                        var isActiveStr = worksheet.Cells[row, 3]?.Value?.ToString()?.Trim();
                        bool isActive = string.Equals(isActiveStr, "true", StringComparison.OrdinalIgnoreCase) || isActiveStr == "1";

                        if (string.IsNullOrEmpty(keyName) || string.IsNullOrEmpty(valueName))
                            continue;

                        string keyRowKey;

                        // Kiểm tra xem key đã tồn tại chưa
                        if (!nameToRowKeyMap.ContainsKey(keyName))
                        {
                            // Tạo key mới
                            var newKey = new MasterDataKey
                            {
                                Name = keyName,
                                PartitionKey = keyName, // PartitionKey của key = Name
                                RowKey = Guid.NewGuid().ToString(), // RowKey là Guid duy nhất
                                CreatedBy = HttpContext.User.GetCurrentUserDetails().Name,
                                IsActive = isActive
                            };
                            newKeysList.Add(newKey);

                            // Cập nhật map
                            nameToRowKeyMap[keyName] = newKey.RowKey;

                            keyRowKey = newKey.RowKey;
                        }
                        else
                        {
                            keyRowKey = nameToRowKeyMap[keyName];
                        }

                        // Tạo value với PartitionKey = RowKey của key
                        var masterDataValue = new MasterDataValue
                        {
                            RowKey = Guid.NewGuid().ToString(),
                            PartitionKey = keyRowKey, // PartitionKey của value = RowKey của key
                            Name = valueName,
                            CreatedBy = HttpContext.User.GetCurrentUserDetails().Name,
                            IsActive = isActive
                        };
                        masterValueList.Add(masterDataValue);
                    }
                }
            }

            // Lưu các key mới vào database và đảm bảo commit trước khi trả về values
            if (newKeysList.Any())
            {
                await _masterData.InsertListMasterKeysAsync(newKeysList);

                // Đảm bảo keys đã được commit trước khi trả về
                await EnsureKeysCommittedAsync(newKeysList);
            }

            return masterValueList;
        }

        // Phương thức mới để đảm bảo keys đã được lưu vào database
        private async Task EnsureKeysCommittedAsync(List<MasterDataKey> keys)
        {
            // Nếu đang dùng EF Core, có thể sử dụng SaveChangesAsync lại một lần nữa
            // hoặc thực hiện một truy vấn để xác nhận các keys đã tồn tại

            // Ví dụ, kiểm tra xem các keys có thể được truy xuất
            foreach (var key in keys)
            {
                try
                {
                    // Thử lấy key để xác nhận đã được lưu
                    var existingKey = await _masterData.GetMasterKeyByNameAsync(key.Name);
                    if (existingKey == null)
                    {
                        Console.WriteLine($"Warning: Key {key.Name} not found after insert");
                        // Có thể thử insert lại hoặc throw exception tùy vào yêu cầu
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error verifying key {key.Name}: {ex.Message}");
                    // Xử lý ngoại lệ nếu cần
                }
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UploadExcel()
        {
            var files = Request.Form.Files;
            if (!files.Any())
            {
                return Json(new { Error = true, Text = "Please upload a file" });
            }

            var excelFile = files.First();
            if (excelFile.Length <= 0)
            {
                return Json(new { Error = true, Text = "File is empty" });
            }

            try
            {
                var masterValues = await ParseMasterDataExcel(excelFile);
                if (masterValues.Any())
                {
                    Console.WriteLine($"Uploading {masterValues.Count} master values...");

                    // Đảm bảo values có PartitionKey (RowKey của keys) hợp lệ
                    var validValues = await ValidateValuesAsync(masterValues);

                    if (validValues.Any())
                    {
                        await _masterData.UploadBulkMasterData(validValues);
                        Console.WriteLine("UploadBulkMasterData completed successfully.");
                    }
                    else
                    {
                        Console.WriteLine("No valid master values to upload after validation.");
                    }
                }
                else
                {
                    Console.WriteLine("No master values to upload.");
                }

                return Json(new { success = true, message = "Upload successful!" });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in UploadExcel: {ex.Message}\nStackTrace: {ex.StackTrace}");
                return Json(new { Error = true, Text = ex.Message });
            }
        }

        // Thêm phương thức để xác nhận values có PartitionKey hợp lệ
        private async Task<List<MasterDataValue>> ValidateValuesAsync(List<MasterDataValue> values)
        {
            // Lấy tất cả keys hiện có để xác nhận rằng PartitionKey của values là hợp lệ
            var existingKeys = await _masterData.GetAllMasterKeysAsync();
            var validRowKeys = existingKeys.Select(k => k.RowKey).ToHashSet();

            var validValues = new List<MasterDataValue>();

            foreach (var value in values)
            {
                if (validRowKeys.Contains(value.PartitionKey))
                {
                    validValues.Add(value);
                }
                else
                {
                    Console.WriteLine($"Warning: Value {value.Name} has invalid PartitionKey {value.PartitionKey}");
                    // Có thể log thêm hoặc xử lý theo nhu cầu
                }
            }

            return validValues;
        }

        /*
        public async Task<List<MasterDataValue>> ParseMasterDataExcel(IFormFile excelFile)
        {
            var masterValueList = new List<MasterDataValue>();
            var newKeysList = new List<MasterDataKey>();

            // Lấy tất cả master keys hiện có
            var existingKeys = await _masterData.GetAllMasterKeysAsync();

            // Dictionary để map giữa tên key và rowKey
            var nameToRowKeyMap = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);

            // Map tên key với rowKey
            foreach (var key in existingKeys)
            {
                nameToRowKeyMap[key.Name] = key.RowKey;
            }

            ExcelPackage.License.SetNonCommercialPersonal("HoaiDream");
            using (var memoryStream = new MemoryStream())
            {
                await excelFile.CopyToAsync(memoryStream);
                memoryStream.Position = 0;
                using (var package = new ExcelPackage(memoryStream))
                {
                    var worksheet = package.Workbook.Worksheets[0];
                    int rowCount = worksheet.Dimension?.Rows ?? 0;

                    if (rowCount < 2) return masterValueList; // Không có dữ liệu

                    for (int row = 2; row <= rowCount; row++)
                    {
                        var keyName = worksheet.Cells[row, 1]?.Value?.ToString()?.Trim();
                        var valueName = worksheet.Cells[row, 2]?.Value?.ToString()?.Trim();
                        var isActiveStr = worksheet.Cells[row, 3]?.Value?.ToString()?.Trim();
                        bool isActive = string.Equals(isActiveStr, "true", StringComparison.OrdinalIgnoreCase) || isActiveStr == "1";

                        if (string.IsNullOrEmpty(keyName) || string.IsNullOrEmpty(valueName))
                            continue;

                        string keyRowKey;

                        // Kiểm tra xem key đã tồn tại chưa
                        if (!nameToRowKeyMap.ContainsKey(keyName))
                        {
                            // Tạo key mới
                            var newKey = new MasterDataKey
                            {
                                Name = keyName,
                                PartitionKey = keyName, // PartitionKey = Name
                                RowKey = Guid.NewGuid().ToString(), // RowKey là Guid duy nhất
                                CreatedBy = HttpContext.User.GetCurrentUserDetails().Name,
                                IsActive = isActive
                            };
                            newKeysList.Add(newKey);

                            // Cập nhật map
                            nameToRowKeyMap[keyName] = newKey.RowKey;

                            keyRowKey = newKey.RowKey;
                        }
                        else
                        {
                            keyRowKey = nameToRowKeyMap[keyName];
                        }

                        // Tạo value với PartitionKey = keyName
                        var masterDataValue = new MasterDataValue
                        {
                            RowKey = Guid.NewGuid().ToString(),
                            PartitionKey = keyRowKey, // PartitionKey của value = Name của key
                            Name = valueName,
                            CreatedBy = HttpContext.User.GetCurrentUserDetails().Name,
                            IsActive = isActive
                        };
                        masterValueList.Add(masterDataValue);
                    }
                }
            }

            // Lưu các key mới vào database
            if (newKeysList.Any())
            {
                await _masterData.InsertListMasterKeysAsync(newKeysList);
            }

            return masterValueList;
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UploadExcel()
        {
            var files = Request.Form.Files;
            if (!files.Any())
            {
                return Json(new { Error = true, Text = "Please upload a file" });
            }

            var excelFile = files.First();
            if (excelFile.Length <= 0)
            {
                return Json(new { Error = true, Text = "File is empty" });
            }

            try
            {
                var masterValues = await ParseMasterDataExcel(excelFile);
                if (masterValues.Any())
                {
                    await _masterData.UploadBulkMasterData(masterValues);
                }

                return Json(new { success = true, message = "Upload successful!" });
            }
            catch (Exception ex)
            {
                return Json(new { Error = true, Text = ex.Message });
            }
        }
        */
    }
}
