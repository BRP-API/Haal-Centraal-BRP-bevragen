using BrpProxy.Validators;
using FluentAssertions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xunit;

namespace BrpProxy.Tests
{
    public class AddAlwaysReturnedFieldsTests
    {
        [Theory]
        [InlineData("geheimhoudingPersoonsgegevens")]
        [InlineData("opschortingBijhouding")]
        [InlineData("overlijden.indicatieOverleden")]
        [InlineData("rni")]
        public void AlwaysReturnedFields(string expectedField)
        {
            new List<string>().AddAlwaysReturnedFields().Should().Contain(expectedField);
        }
    }
}
