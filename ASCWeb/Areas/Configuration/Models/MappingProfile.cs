﻿using ASC.Model.Models;
using AutoMapper;

namespace ASCWeb.Areas.Configuration.Models
{
    public class MappingProfile : Profile
    {
        public MappingProfile() {
            CreateMap<MasterDataKey, MasterDataKeyViewModel>();

            CreateMap<MasterDataKeyViewModel, MasterDataKey>();

            CreateMap<MasterDataValue, MasterDataValueViewModel>();

            CreateMap<MasterDataValueViewModel, MasterDataValue>();
        }
    }
}
