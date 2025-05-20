using Microsoft.Extensions.Caching.Distributed;
using ASC.Business.Interfaces;
using Newtonsoft.Json;
using ASC.Model.Models;

namespace ASCWeb.Data
{
    public class MasterDataCacheOperations : IMasterDataCacheOperations
    {
        private readonly IDistributedCache _cache;
        private readonly IMasterDataOperations _masterData;
        private readonly string _masterDataCacheName;

        public MasterDataCacheOperations(
            IDistributedCache cache,
            IMasterDataOperations masterData,
            IConfiguration config)
        {
            _cache = cache;
            _masterData = masterData;
            var instancePrefix = config["CacheSettings:CacheInstance"] ?? string.Empty;
            _masterDataCacheName = "MasterDataCache";
        }

        public async Task CreateMasterDataCacheAsync()
        {
            var masterDataCache = new MasterDataCache
            {
                Keys = (await _masterData.GetAllMasterKeysAsync()).Where(p => p.IsActive == true).ToList(),
                Values = (await _masterData.GetAllMasterValuesAsync()).Where(p => p.IsActive == true).ToList()
            };

            var json = JsonConvert.SerializeObject(masterDataCache);
            await _cache.SetStringAsync(_masterDataCacheName, json);
        }

        public async Task<MasterDataCache> GetMasterDataCacheAsync()
        {
            var json = await _cache.GetStringAsync(_masterDataCacheName);

            // Nếu không có cache thì tạo lại
            if (string.IsNullOrEmpty(json))
            {
                await CreateMasterDataCacheAsync();
                json = await _cache.GetStringAsync(_masterDataCacheName);
            }

            // Nếu vẫn không có dữ liệu sau khi tạo thì trả về rỗng để tránh null exception
            if (string.IsNullOrEmpty(json))
            {
                return new MasterDataCache
                {
                    Keys = new List<MasterDataKey>(),
                    Values = new List<MasterDataValue>()
                };
            }

            return JsonConvert.DeserializeObject<MasterDataCache>(json);
        }
    }
}
