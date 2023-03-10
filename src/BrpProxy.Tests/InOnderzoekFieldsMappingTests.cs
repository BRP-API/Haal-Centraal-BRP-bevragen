using BrpProxy.Validators;
using FluentAssertions;
using System.Collections.Generic;
using Xunit;
using Xunit.Abstractions;

namespace BrpProxy.Tests
{
    public class InOnderzoekFieldsMappingTests
    {
        private readonly ITestOutputHelper _log;
        private readonly IDictionary<string, string> _mapping;

        public InOnderzoekFieldsMappingTests(ITestOutputHelper log)
        {
            _log = log;
            _mapping = FieldsHelper.SetupFieldInOnderzoekMapping();
        }

        [Theory]
        [InlineData("inOnderzoek.burgerservicenummer")]
        public void InOnderzoekFieldsHaveNoInOnderzoekMapping(string field)
        {
            _mapping[field].Should().BeEmpty();
        }

        [Theory]
        [InlineData("aNummer")]
        [InlineData("datumEersteInschrijvingGBA")]
        public void FieldsWithoutInOnderzoekMapping(string field)
        {
            _mapping[field].Should().BeEmpty();
        }

        [Theory]
        [InlineData("burgerservicenummer", "inOnderzoek.burgerservicenummer")]
        [InlineData("geslacht", "inOnderzoek.geslacht")]
        [InlineData("geslacht.code", "inOnderzoek.geslacht")]
        [InlineData("geslacht.omschrijving", "inOnderzoek.geslacht")]
        [InlineData("geboorte", "geboorte.inOnderzoek")]
        [InlineData("geboorte.datum", "geboorte.inOnderzoek.datum")]
        [InlineData("geboorte.datum.type", "geboorte.inOnderzoek.datum")]
        [InlineData("indicatieGezagMinderjarige", "inOnderzoek.indicatieGezagMinderjarige")]
        [InlineData("indicatieCurateleRegister", "inOnderzoek.indicatieCurateleRegister")]
        [InlineData("kinderen", "kinderen.inOnderzoek")]
        [InlineData("kinderen.burgerservicenummer", "kinderen.inOnderzoek.burgerservicenummer")]
        [InlineData("kinderen.geboorte", "kinderen.geboorte.inOnderzoek")]
        [InlineData("kinderen.geboorte.datum", "kinderen.geboorte.inOnderzoek.datum")]
        [InlineData("kinderen.naam", "kinderen.naam.inOnderzoek")]
        [InlineData("kinderen.naam.voornamen", "kinderen.naam.inOnderzoek.voornamen")]
        public void FieldsWithInOnderzoekMapping(string field, string expected)
        {
            _mapping[field].Should().Be(expected, $"{field} heeft inOnderzoek veld: {_mapping[field]}, maar moet zijn: {expected}");
        }
    }
}
