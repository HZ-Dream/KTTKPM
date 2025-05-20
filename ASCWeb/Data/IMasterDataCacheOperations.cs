namespace ASCWeb.Data
{
    public interface IMasterDataCacheOperations
    {
        Task<MasterDataCache> GetMasterDataCacheAsync();

        Task CreateMasterDataCacheAsync();
    }
}
