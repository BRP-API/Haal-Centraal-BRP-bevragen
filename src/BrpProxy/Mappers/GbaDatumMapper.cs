using HaalCentraal.BrpProxy.Generated;
using System.Globalization;
using System.Text.RegularExpressions;

namespace BrpProxy.Mappers;

public static class GbaDatumMapper
{
    private static readonly Regex GbaDatumRegex = new("^(?<jaar>[0-9]{4})(?<maand>[0-9]{2})(?<dag>[0-9]{2})$");

    public static AbstractDatum Map(this string datum)
    {
        if (GbaDatumRegex.IsMatch(datum))
        {
            var match = GbaDatumRegex.Match(datum);
            var jaar = int.Parse(match.Groups["jaar"].Value, CultureInfo.InvariantCulture);
            var maand = int.Parse(match.Groups["maand"].Value, CultureInfo.InvariantCulture);
            var dag = int.Parse(match.Groups["dag"].Value, CultureInfo.InvariantCulture);

            if (jaar != 0 && maand != 0 && dag != 0)
            {
                return new VolledigeDatum { Datum = new DateTime(jaar, maand, dag) };
            }
            if (jaar == 0 && maand == 0 && dag == 0)
            {
                return new DatumOnbekend();
            }
            if (jaar != 0 && maand != 0 && dag == 0)
            {
                return new JaarMaandDatum { Jaar = jaar, Maand = maand };
            }
            if (jaar != 0 && maand == 0 && dag == 0)
            {
                return new JaarDatum { Jaar = jaar };
            }
        }
        return new DatumOnbekend();
    }

    public static int? Leeftijd(this AbstractDatum datum)
    {
        return datum switch
        {
            VolledigeDatum d => d.Datum!.Value.Leeftijd(DateTimeOffset.Now),
            JaarMaandDatum d => d.Leeftijd(DateTimeOffset.Now),
            _ => null
        };
    }

    public static int Leeftijd(this DateTimeOffset datum, DateTimeOffset peildatum)
    {
        var leeftijd = peildatum.Year - datum.Year;

        if(peildatum.Month < datum.Month ||
            (peildatum.Month == datum.Month && peildatum.Day < datum.Day))
        {
            leeftijd--;
        }

        return leeftijd;
    }

    public static int? Leeftijd(this JaarMaandDatum datum, DateTimeOffset peildatum)
    {
        return datum.Maand != peildatum.Month
            ? new DateTimeOffset(new DateTime(datum.Jaar, datum.Maand, 1)).Leeftijd(peildatum)
            : null;
    }
}
