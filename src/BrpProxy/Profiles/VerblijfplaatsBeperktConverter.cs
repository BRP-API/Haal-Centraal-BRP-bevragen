using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public static class VerblijfplaatsBeperktConverterExtensions
{
    public static bool IsOnbekendVerblijfplaatsBuitenland(this GbaVerblijfplaatsBeperkt source) =>
        source.Land != null &&
        source.Land.Code == "0000";

    public static bool IsVerblijfplaatsBuitenland(this GbaVerblijfplaatsBeperkt source) =>
        source.Land != null &&
        source.Land.Code != "0000";

    public static bool IsAdres(this GbaVerblijfplaatsBeperkt source) => !string.IsNullOrWhiteSpace(source.Straat);

    public static bool IsLocatie(this GbaVerblijfplaatsBeperkt source) => !string.IsNullOrWhiteSpace(source.Locatiebeschrijving);
}

public class VerblijfplaatsBeperktConverter : ITypeConverter<GbaVerblijfplaatsBeperkt, AbstractVerblijfplaatsBeperkt?>
{
    public AbstractVerblijfplaatsBeperkt? Convert(GbaVerblijfplaatsBeperkt source, AbstractVerblijfplaatsBeperkt? destination, ResolutionContext context)
    {
        if (source == null)
        {
            return null;
        }
        if (source.IsOnbekendVerblijfplaatsBuitenland())
        {
            return context.Mapper.Map<VerblijfplaatsOnbekendBeperkt>(source);
        }
        if (source.IsVerblijfplaatsBuitenland())
        {
            return context.Mapper.Map<VerblijfplaatsBuitenlandBeperkt>(source);
        }
        if (source.IsAdres())
        {
            return context.Mapper.Map<AdresBeperkt>(source);
        }
        if (source.IsLocatie())
        {
            return context.Mapper.Map<LocatieBeperkt>(source);
        }
        return null;
    }
}
