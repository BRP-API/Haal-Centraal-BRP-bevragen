using HaalCentraal.BrpProxy.Generated;

namespace BrpProxy.Mappers;

public static class VoorlettersMapper
{
    public static string Voorletters(this INaam naam) => naam.Voornamen.MapNaarVoorletters();

    private static string MapNaarVoorletters(this string voornamen)
    {
        if (string.IsNullOrWhiteSpace(voornamen) ||
            voornamen == ".")
        {
            return voornamen;
        }

        var voorletters = from voornaam in voornamen.Split(" ")
                          select voornaam.Trim().Length > 1
                             ? voornaam[..1] + "."
                             : voornaam + " ";
        return string.Join("", voorletters).Trim();
    }
}
