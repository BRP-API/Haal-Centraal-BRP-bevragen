using BrpProxy.Validators;
using FluentAssertions;
using HaalCentraal.BrpProxy.Generated;
using System.IO;
using System.Linq;
using Xunit;

namespace BrpProxy.Tests
{
    public class FieldsMappingTests
    {
        [Fact]
        public void ValidatePersoonMapping()
        {
            var persoonFields = typeof(Persoon).GetPropertyPaths("HaalCentraal");

            foreach (var line in File.ReadAllLines("../../../../../features/fields-mapping-Persoon.csv").Skip(1))
            {
                var field = line[(line.IndexOf(',')+1)..];

                persoonFields.Contains(field).Should().BeTrue(field);
            }
        }

        [Fact]
        public void ValidatePersoonBeperktMapping()
        {
            var persoonBeperktFields = typeof(PersoonBeperkt).GetPropertyPaths("HaalCentraal");

            foreach (var line in File.ReadAllLines("../../../../../features/fields-mapping-PersoonBeperkt.csv").Skip(1))
            {
                var field = line[(line.IndexOf(',') + 1)..];

                persoonBeperktFields.Contains(field).Should().BeTrue(field);
            }
        }
    }
}
