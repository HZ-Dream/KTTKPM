using ASC.Business.Interfaces;
using ASC.DataAccess;
using ASC.Model.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASC.Business
{
    public class MasterDataOperations : IMasterDataOperations
    {
        private readonly IUnitOfWork _unitOfWork;

        public MasterDataOperations(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<List<MasterDataKey>> GetAllMasterKeysAsync()
        {
            var masterKeys = await _unitOfWork.Repository<MasterDataKey>().FindAllAsync();
            return masterKeys.ToList();
        }

        public async Task<List<MasterDataKey>> GetMasterKeyByNameAsync(string name)
        {
            var masterKeys = await _unitOfWork.Repository<MasterDataKey>().FindAllByPartitionKeyAsync(name);
            return masterKeys.ToList();
        }

        public async Task<bool> InsertMasterKeyAsync(MasterDataKey key)
        {
            using (_unitOfWork)
            {
                await _unitOfWork.Repository<MasterDataKey>().AddAsync(key);
                _unitOfWork.CommitTransaction();
                return true;
            }
        }

        public async Task<bool> InsertListMasterKeysAsync(List<MasterDataKey> keys)
        {
            foreach (var key in keys)
            {
                await _unitOfWork.Repository<MasterDataKey>().AddAsync(key);
            }
            _unitOfWork.CommitTransaction();
            return true;
        }


        public async Task<List<MasterDataValue>> GetAllMasterValuesByKeyAsync(string key)
        {
            try
            {
                var masterKeys = await _unitOfWork.Repository<MasterDataValue>().FindAllByPartitionKeyAsync(key);
                return masterKeys.ToList();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
            return null;
        }

        public async Task<MasterDataValue> GetMasterValueByNameAsync(string key, string name)
        {
            var masterValues = await _unitOfWork.Repository<MasterDataValue>().FindAsync(key, name);
            return masterValues;
        }

        public async Task<bool> InsertMasterValueAsync(MasterDataValue value)
        {
            using (_unitOfWork)
            {
                await _unitOfWork.Repository<MasterDataValue>().AddAsync(value);
                _unitOfWork.CommitTransaction();
                return true;
            }
        }

        public async Task<bool> UpdateMasterKeyAsync(string originalPartitionKey, MasterDataKey key)
        {
            using (_unitOfWork)
            {
                var masterKey = await _unitOfWork.Repository<MasterDataKey>().
                    FindAsync(originalPartitionKey, key.RowKey);
                masterKey.IsActive = key.IsActive;
                masterKey.IsDeleted = key.IsDeleted;
                masterKey.Name = key.Name;
                _unitOfWork.Repository<MasterDataKey>().Update(masterKey);
                _unitOfWork.CommitTransaction();
                return true;
            }
        }

        public async Task<bool> UpdateMasterValueAsync(string originalPartitionKey, string originalRowKey, MasterDataValue value)
        {
            using (_unitOfWork)
            {
                var masterValue = await _unitOfWork.Repository<MasterDataValue>()
                    .FindAsync(originalPartitionKey, originalRowKey);
                masterValue.IsActive = value.IsActive;
                masterValue.IsDeleted = value.IsDeleted;
                masterValue.Name = value.Name;

                _unitOfWork.Repository<MasterDataValue>().Update(masterValue);
                _unitOfWork.CommitTransaction();
                return true;
            }
        }

        public async Task<List<MasterDataValue>> GetAllMasterValuesAsync()
        {
            var masterValues = await _unitOfWork.Repository<MasterDataValue>().FindAllAsync();
            return masterValues.ToList();
        }


        public async Task<bool> UploadBulkMasterData(List<MasterDataValue> values)
        {
            using (_unitOfWork)
            {
                try
                {
                    // Thử lấy tất cả values hiện có
                    IEnumerable<MasterDataValue> allExistingValues;
                    try
                    {
                        Console.WriteLine("Attempting to call FindAllAsync...");
                        allExistingValues = await _unitOfWork.Repository<MasterDataValue>().FindAllAsync();
                        Console.WriteLine($"Retrieved {allExistingValues.Count()} existing values.");
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error in FindAllAsync: {ex.Message}\nStackTrace: {ex.StackTrace}");
                        // Bypass tạm thời: Giả sử không có value hiện có
                        allExistingValues = new List<MasterDataValue>();
                    }

                    // Dictionary lồng nhau để lưu trữ (PartitionKey -> (Name -> Value))
                    var existingValuesDict = new Dictionary<string, Dictionary<string, MasterDataValue>>(StringComparer.OrdinalIgnoreCase);

                    // Xây dựng dictionary để tìm kiếm nhanh
                    foreach (var existingValue in allExistingValues)
                    {
                        if (!existingValuesDict.ContainsKey(existingValue.PartitionKey))
                        {
                            existingValuesDict[existingValue.PartitionKey] = new Dictionary<string, MasterDataValue>(StringComparer.OrdinalIgnoreCase);
                        }
                        existingValuesDict[existingValue.PartitionKey][existingValue.Name] = existingValue;
                    }

                    // Thêm hoặc cập nhật value
                    foreach (var value in values)
                    {
                        // Kiểm tra từng cấp của dictionary một cách an toàn
                        if (existingValuesDict.TryGetValue(value.PartitionKey, out var valuesByName) &&
                            valuesByName.TryGetValue(value.Name, out var existingValue))
                        {
                            // Value đã tồn tại - cập nhật
                            existingValue.IsActive = value.IsActive;
                            existingValue.IsDeleted = value.IsDeleted;
                            existingValue.Name = value.Name;
                            existingValue.CreatedBy = value.CreatedBy;
                            existingValue.UpdatedBy = value.UpdatedBy;

                            _unitOfWork.Repository<MasterDataValue>().Update(existingValue);
                        }
                        else
                        {
                            // Value chưa tồn tại - thêm mới
                            await _unitOfWork.Repository<MasterDataValue>().AddAsync(value);
                        }
                    }

                    // Commit transaction
                    Console.WriteLine("Committing transaction...");
                    _unitOfWork.CommitTransaction();
                    Console.WriteLine("Transaction committed successfully.");
                    return true;
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error in UploadBulkMasterData: {ex.Message}\nStackTrace: {ex.StackTrace}");
                    throw;
                }
            }
        }

        /*

        public async Task<bool> UploadBulkMasterData(List<MasterDataValue> values)
        {
            using (_unitOfWork)
            {
                try
                {
                    // Lấy tất cả values hiện có trong một lần truy vấn
                    var allExistingValues = await _unitOfWork.Repository<MasterDataValue>().FindAllAsync();

                    // Dictionary lồng nhau để lưu trữ (PartitionKey -> (Name -> Value))
                    var existingValuesDict = new Dictionary<string, Dictionary<string, MasterDataValue>>();

                    // Xây dựng dictionary để tìm kiếm nhanh
                    foreach (var existingValue in allExistingValues)
                    {
                        if (!existingValuesDict.ContainsKey(existingValue.PartitionKey))
                        {
                            existingValuesDict[existingValue.PartitionKey] = new Dictionary<string, MasterDataValue>();
                        }

                        existingValuesDict[existingValue.PartitionKey][existingValue.Name] = existingValue;
                    }

                    foreach (var value in values)
                    {
                        // Kiểm tra từng cấp của dictionary một cách an toàn
                        if (existingValuesDict.TryGetValue(value.PartitionKey, out var valuesByName) &&
                            valuesByName.TryGetValue(value.Name, out var existingValue))
                        {
                            // Value đã tồn tại - cập nhật
                            existingValue.IsActive = value.IsActive;
                            existingValue.IsDeleted = value.IsDeleted;
                            existingValue.Name = value.Name;

                            _unitOfWork.Repository<MasterDataValue>().Update(existingValue);
                        }
                        else
                        {
                            // Value chưa tồn tại - thêm mới
                            await _unitOfWork.Repository<MasterDataValue>().AddAsync(value);
                        }
                    }

                    _unitOfWork.CommitTransaction();
                    return true;
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error in UploadBulkMasterData: {ex.Message}");
                    throw;
                }
            }
        }
        */

    }
}
