using AutoMapper;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public static class VerblijfplaatsConverterExtensions
{
    public static bool IsOnbekendVerblijfplaatsBuitenland(this GbaVerblijfplaats source) =>
        source.Land != null &&
        source.Land.Code == "0000";

    public static bool IsVerblijfplaatsBuitenland(this GbaVerblijfplaats source) =>
        source.Land != null &&
        source.Land.Code != "0000";

    public static bool IsAdres(this GbaVerblijfplaats source) => !string.IsNullOrWhiteSpace(source.Straat);

    public static bool IsLocatie(this GbaVerblijfplaats source) => !string.IsNullOrWhiteSpace(source.Locatiebeschrijving);
}

public class VerblijfplaatsConverter : ITypeConverter<GbaVerblijfplaats, AbstractVerblijfplaats?>
{
    public AbstractVerblijfplaats? Convert(GbaVerblijfplaats source, AbstractVerblijfplaats? destination, ResolutionContext context)
    {
        if (source == null)
        {
            return null;
        }
        if (source.IsOnbekendVerblijfplaatsBuitenland())
        {
            return context.Mapper.Map<VerblijfplaatsOnbekend>(source);
        }
        if(source.IsVerblijfplaatsBuitenland())
        {
            return context.Mapper.Map<VerblijfplaatsBuitenland>(source);
        }
        if(source.IsAdres())
        {
            return context.Mapper.Map<Adres>(source);
        }
        if (source.IsLocatie())
        {
            return context.Mapper.Map<Locatie>(source);
        }
        return null;
    }
}
