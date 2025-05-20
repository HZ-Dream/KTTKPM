using ASC.Business.Interfaces;
using ASC.Model.BaseTypes;
using ASC.Model.Models;
using ASC.Ultilities;
using ASCWeb.Areas.ServiceRequests.Models;
using ASCWeb.Configuration;
using ASCWeb.Controllers;
using ASCWeb.Data;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace ASCWeb.Areas.ServiceRequests.Controllers
{
    [Area("ServiceRequests")]
    public class ServiceRequestController : BaseController
    {
        private readonly IServiceRequestOperations _serviceRequestOperations;
        private readonly IMapper _mapper;
        private readonly IMasterDataCacheOperations _masterData;

        public ServiceRequestController(IServiceRequestOperations serviceRequestOperations, IMapper mapper, IMasterDataCacheOperations masterData)
        {
            _serviceRequestOperations = serviceRequestOperations;
            _mapper = mapper;
            _masterData = masterData;
        }

        [HttpGet]
        public async Task<IActionResult> ServiceRequest()
        {
            var masterData = await _masterData.GetMasterDataCacheAsync();

            // Bước 1: Tìm ID (RowKey) tương ứng với "VehicleType" và "VehicleName"
            var vehicleTypeKey = masterData.Keys
                .FirstOrDefault(k => k.PartitionKey == "VehicleType")?.RowKey;

            var vehicleNameKey = masterData.Keys
                .FirstOrDefault(k => k.PartitionKey == "VehicleName")?.RowKey;

            // Bước 2: Lọc giá trị dựa theo RowKey
            ViewBag.VehicleTypes = masterData.Values
                .Where(p => p.PartitionKey == vehicleTypeKey)
                .ToList();

            ViewBag.VehicleNames = masterData.Values
                .Where(p => p.PartitionKey == vehicleNameKey)
                .ToList();


            return View(new NewServiceRequestViewModel());
        }


        [HttpPost]
        public async Task<IActionResult> ServiceRequest(NewServiceRequestViewModel request)
        {
            if (!ModelState.IsValid)
            {
                var masterData = await _masterData.GetMasterDataCacheAsync();
                // Bước 1: Tìm ID (RowKey) tương ứng với "VehicleType" và "VehicleName"
                var vehicleTypeKey = masterData.Keys
                    .FirstOrDefault(k => k.PartitionKey == "VehicleType")?.RowKey;

                var vehicleNameKey = masterData.Keys
                    .FirstOrDefault(k => k.PartitionKey == "VehicleName")?.RowKey;

                // Bước 2: Lọc giá trị dựa theo RowKey
                ViewBag.VehicleTypes = masterData.Values
                    .Where(p => p.PartitionKey == vehicleTypeKey)
                    .ToList();

                ViewBag.VehicleNames = masterData.Values
                    .Where(p => p.PartitionKey == vehicleNameKey)
                    .ToList();
                return View(request);
            }

            var serviceRequest = _mapper.Map<NewServiceRequestViewModel, ServiceRequest>(request);

            serviceRequest.PartitionKey = HttpContext.User.GetCurrentUserDetails().Email;
            serviceRequest.RowKey = Guid.NewGuid().ToString();
            serviceRequest.RequestedDate = request.RequestedDate;
            serviceRequest.Status = Status.New.ToString();
            await _serviceRequestOperations.CreateServiceRequestAsync(serviceRequest);

            return RedirectToAction("Dashboard", "Dashboard", new { Area = "ServiceRequests" });
        }
    }
}
