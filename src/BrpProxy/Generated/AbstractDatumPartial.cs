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

    public static bool operator <(AbstractDatum left, AbstractDatum right)
    {
        var leftYear = 0;
        var leftMonth = 0;
        var leftDay = 0;
        var rightYear = 0;
        var rightMonth = 0;
        var rightDay = 0;
        switch (left)
        {
            case VolledigeDatum l:
                leftYear = l.Datum!.Value.Year;
                leftMonth = l.Datum!.Value.Month;
                leftDay = l.Datum!.Value.Day;
                break;
            case JaarMaandDatum l:
                leftYear = l.Jaar;
                leftMonth = l.Maand;
                break;
            case JaarDatum l:
                leftYear = l.Jaar;
                break;
            default:
                break;
        }
        switch (right)
        {
            case VolledigeDatum r:
                rightYear = r.Datum!.Value.Year;
                rightMonth = r.Datum!.Value.Month;
                rightDay = r.Datum!.Value.Day;
                break;
            case JaarMaandDatum r:
                rightYear = r.Jaar;
                rightMonth = r.Maand;
                break;
            case JaarDatum r:
                rightYear = r.Jaar;
                break;
            default:
                break;
        }

        return leftYear < rightYear ||
            (leftYear == rightYear && leftMonth < rightMonth) ||
            (leftYear == rightYear && leftMonth == rightMonth && leftDay < rightDay);
    }

    public static bool operator >(AbstractDatum left, AbstractDatum right)
    {
        var leftYear = 0;
        var leftMonth = 0;
        var leftDay = 0;
        var rightYear = 0;
        var rightMonth = 0;
        var rightDay = 0;
        switch (left)
        {
            case VolledigeDatum l:
                leftYear = l.Datum!.Value.Year;
                leftMonth = l.Datum!.Value.Month;
                leftDay = l.Datum!.Value.Day;
                break;
            case JaarMaandDatum l:
                leftYear = l.Jaar;
                leftMonth = l.Maand;
                break;
            case JaarDatum l:
                leftYear = l.Jaar;
                break;
            default:
                break;
        }
        switch (right)
        {
            case VolledigeDatum r:
                rightYear = r.Datum!.Value.Year;
                rightMonth = r.Datum!.Value.Month;
                rightDay = r.Datum!.Value.Day;
                break;
            case JaarMaandDatum r:
                rightYear = r.Jaar;
                rightMonth = r.Maand;
                break;
            case JaarDatum r:
                rightYear = r.Jaar;
                break;
            default:
                break;
        }

        return leftYear > rightYear ||
            (leftYear == rightYear && leftMonth > rightMonth) ||
            (leftYear == rightYear && leftMonth == rightMonth && leftDay > rightDay);
    }
}
