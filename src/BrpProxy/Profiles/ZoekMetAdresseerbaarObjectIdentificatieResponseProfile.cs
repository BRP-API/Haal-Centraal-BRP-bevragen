﻿using AutoMapper;
using HC = HaalCentraal.BrpProxy.Generated;
using Gba = HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class ZoekMetAdresseerbaarObjectIdentificatieResponseProfile : Profile
{
    public ZoekMetAdresseerbaarObjectIdentificatieResponseProfile()
    {
        CreateMap<Gba.ZoekMetAdresseerbaarObjectIdentificatieResponse, HC.ZoekMetAdresseerbaarObjectIdentificatieResponse>();
    }
}
