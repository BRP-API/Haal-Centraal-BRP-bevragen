namespace HaalCentraal.BrpProxy.Generated;

public partial class AbstractDatum
{
    public static bool operator <= (AbstractDatum d, DateTime e)
    {
        if(d is VolledigeDatum datum)
        {
            return datum.Datum <= e;
        }
        else if(d is JaarDatum jaarDatum)
        {
            var peildatum = new DateTime(jaarDatum.Jaar, 1, 1).AddYears(1);
            return peildatum <= e;
        }
        else if(d is JaarMaandDatum jaarMaandDatum)
        {
            var peildatum = new DateTime(jaarMaandDatum.Jaar, jaarMaandDatum.Maand, 1).AddMonths(1);
            return peildatum <= e;
        }
        return false;
    }
    
    public static bool operator >=(AbstractDatum d, DateTime e)
    {
        if (d is VolledigeDatum datum)
        {
            return datum.Datum >= e;
        }
        else if (d is JaarDatum jaarDatum)
        {
            var peildatum = new DateTime(jaarDatum.Jaar, 1, 1).AddYears(1);
            return peildatum >= e;
        }
        else if (d is JaarMaandDatum jaarMaandDatum)
        {
            var peildatum = new DateTime(jaarMaandDatum.Jaar, jaarMaandDatum.Maand, 1).AddMonths(1);
            return peildatum >= e;
        }
        return false;
    }
}
