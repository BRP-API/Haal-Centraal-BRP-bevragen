using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class VerblijfplaatsBeperktConverter : ITypeConverter<GbaVerblijfplaatsBeperkt, AbstractVerblijfplaatsBeperkt>
{
    public AbstractVerblijfplaatsBeperkt Convert(GbaVerblijfplaatsBeperkt source, AbstractVerblijfplaatsBeperkt destination, ResolutionContext context)
    {
        return source.Map();
    }
}
