using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class VerblijfplaatsConverter : ITypeConverter<GbaVerblijfplaats, AbstractVerblijfplaats>
{
    public AbstractVerblijfplaats Convert(GbaVerblijfplaats source, AbstractVerblijfplaats destination, ResolutionContext context)
    {
        return source.Map();
    }
}
