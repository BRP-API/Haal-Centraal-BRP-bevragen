using FluentAssertions;
using HaalCentraal.BrpProxy.Generated;
using System;
using Xunit;

namespace BrpProxy.Tests
{
    public class AbstractDatumTests
    {
        public static TheoryData<AbstractDatum, AbstractDatum, bool> SmallerThanComparisonData => new()
        {
            { new VolledigeDatum { Datum = new DateTime(2023, 6, 1) }, new VolledigeDatum { Datum = new DateTime(2023, 6, 1) }, false },

            { new VolledigeDatum { Datum = new DateTime(2023, 6, 2) }, new VolledigeDatum { Datum = new DateTime(2023, 6, 1) }, false },
            { new VolledigeDatum { Datum = new DateTime(2023, 6, 1) }, new VolledigeDatum { Datum = new DateTime(2023, 6, 2) }, true},

            { new VolledigeDatum { Datum = new DateTime(2023, 6, 1) }, new JaarMaandDatum { Jaar = 2023, Maand = 6 }, false },
            { new VolledigeDatum { Datum = new DateTime(2023, 5, 30) }, new JaarMaandDatum { Jaar = 2023, Maand = 6 }, true },
            { new JaarMaandDatum { Jaar = 2023, Maand = 6 }, new VolledigeDatum { Datum = new DateTime(2023, 6, 1) }, true },

            { new VolledigeDatum { Datum = new DateTime(2023, 6, 1) }, new JaarDatum { Jaar = 2023 }, false },
            { new JaarDatum { Jaar = 2023 }, new VolledigeDatum { Datum = new DateTime(2023, 6, 1) }, true },

            { new VolledigeDatum { Datum = new DateTime(2023, 6, 1) }, new DatumOnbekend(), false },
            { new DatumOnbekend(), new VolledigeDatum { Datum = new DateTime(2023, 6, 1)}, true },

            { new JaarMaandDatum { Jaar = 2023, Maand = 6 }, new JaarMaandDatum { Jaar = 2023, Maand = 6 }, false },
            { new JaarMaandDatum { Jaar = 2023, Maand = 7 }, new JaarMaandDatum { Jaar = 2023, Maand = 6 }, false },
            { new JaarMaandDatum { Jaar = 2023, Maand = 5 }, new JaarMaandDatum { Jaar = 2023, Maand = 6 }, true },
        };

        [Theory]
        [MemberData(nameof(SmallerThanComparisonData))]
        public void SmallerThanComparison(AbstractDatum left, AbstractDatum right, bool expected)
        {
            (left < right).Should().Be(expected);
        }
    }
}
