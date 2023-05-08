namespace HaalCentraal.BrpProxy.Generated;

public partial class AbstractDatum
{
    private static DateTime? ToDateTime(AbstractDatum datum)
    {
        return datum switch
        {
            VolledigeDatum v => v.Datum!.Value.DateTime,
            JaarDatum v => new DateTime(v.Jaar, 1, 1).AddYears(1),
            JaarMaandDatum v => new DateTime(v.Jaar, v.Maand, 1).AddMonths(1),
            _ => null
        };
    }

    public static bool operator <= (AbstractDatum d, DateTime e)
    {
        var peildatum = ToDateTime(d);
        return peildatum != null && peildatum <= e;
    }
    
    public static bool operator >=(AbstractDatum d, DateTime e)
    {
        var peildatum = ToDateTime(d);
        return peildatum != null && peildatum >= e;
    }

    private static (int year, int month, int day) ToYearMonthDay(AbstractDatum datum)
    {
        return datum switch
        {
            VolledigeDatum v => (v.Datum!.Value.Year, v.Datum!.Value.Month, v.Datum!.Value.Day),
            JaarMaandDatum v => (v.Jaar, v.Maand, 0),
            JaarDatum v => (v.Jaar, 0, 0),
            _ => (0, 0, 0),
        };
    }

    public static bool operator <(AbstractDatum left, AbstractDatum right)
    {
        (var leftYear, var leftMonth, var leftDay) = ToYearMonthDay(left);
        (var rightYear, var rightMonth, var rightDay) = ToYearMonthDay(right);

        return leftYear < rightYear ||
            (leftYear == rightYear && leftMonth < rightMonth) ||
            (leftYear == rightYear && leftMonth == rightMonth && leftDay < rightDay);
    }

    public static bool operator >(AbstractDatum left, AbstractDatum right)
    {
        (var leftYear, var leftMonth, var leftDay) = ToYearMonthDay(left);
        (var rightYear, var rightMonth, var rightDay) = ToYearMonthDay(right);

        return leftYear > rightYear ||
            (leftYear == rightYear && leftMonth > rightMonth) ||
            (leftYear == rightYear && leftMonth == rightMonth && leftDay > rightDay);
    }
}
