using HaalCentraal.BrpService.Generated;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HaalCentraal.BrpService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PersoonController : Generated.ControllerBase
    {
        public override async Task<ActionResult<IngeschrevenPersoonHalCollectie>> GetIngeschrevenPersonen([FromQuery] string expand, [FromQuery] string fields, [FromQuery] IEnumerable<string> burgerservicenummer, [FromQuery] DateTimeOffset? geboorte__datum, [FromQuery] string geboorte__plaats, [FromQuery] Geslacht_enum? geslachtsaanduiding, [FromQuery] bool? inclusiefOverledenPersonen, [FromQuery] string naam__geslachtsnaam, [FromQuery] string naam__voorvoegsel, [FromQuery] string naam__voornamen, [FromQuery] string verblijfplaats__gemeenteVanInschrijving, [FromQuery] string verblijfplaats__huisletter, [FromQuery] int? verblijfplaats__huisnummer, [FromQuery] string verblijfplaats__huisnummertoevoeging, [FromQuery] string verblijfplaats__nummeraanduidingIdentificatie, [FromQuery] string verblijfplaats__straat, [FromQuery] string verblijfplaats__postcode)
        {
            return Ok(new IngeschrevenPersoonHalCollectie
            {
                _embedded = new IngeschrevenPersoonHalCollectieEmbedded
                {
                    Ingeschrevenpersonen = new List<IngeschrevenPersoonBeperktHal>
                     {
                         new IngeschrevenPersoonBeperktHal
                         {
                             Geboortedatum = new GbaDatum { Waarde = 20210124 }
                         },
                         new IngeschrevenPersoonBeperktHal
                         {
                             Geboortedatum = new GbaDatum { Waarde = 20210100 }
                         },
                         new IngeschrevenPersoonBeperktHal
                         {
                             Geboortedatum = new GbaDatum { Waarde = 20210000 }
                         },
                         new IngeschrevenPersoonBeperktHal
                         {
                             Geboortedatum = new OnbekendDatum()
                         },
                         new IngeschrevenPersoonBeperktHal
                         {
                             Geboortedatum = new Datum { Waarde = new DateTime(2021, 1, 24) }
                         },
                         new IngeschrevenPersoonBeperktHal
                         {
                             Geboortedatum = new JaarMaandDatum { Jaar=2021, Maand=1 }
                         },
                         new IngeschrevenPersoonBeperktHal
                         {
                             Geboortedatum = new JaarDatum { Jaar=2021 }
                         },
                     }
                }
            });
        }

        public override Task<ActionResult<IngeschrevenPersoonHalBasis>> GetIngeschrevenPersoon(string burgerservicenummer, [FromQuery] string expand, [FromQuery] string fields)
        {
            throw new NotImplementedException();
        }
        //public override Task<ActionResult<IngeschrevenPersoonHalCollectie>> GetIngeschrevenPersonen([FromQuery] string expand, [FromQuery] string fields, [FromQuery] IEnumerable<string> burgerservicenummer, [FromQuery] DateTimeOffset? geboorte__datum, [FromQuery] string geboorte__plaats, [FromQuery] Geslacht_enum? geslachtsaanduiding, [FromQuery] bool? inclusiefOverledenPersonen, [FromQuery] string naam__geslachtsnaam, [FromQuery] string naam__voorvoegsel, [FromQuery] string naam__voornamen, [FromQuery] string verblijfplaats__gemeenteVanInschrijving, [FromQuery] string verblijfplaats__huisletter, [FromQuery] int? verblijfplaats__huisnummer, [FromQuery] string verblijfplaats__huisnummertoevoeging, [FromQuery] string verblijfplaats__nummeraanduidingIdentificatie, [FromQuery] string verblijfplaats__straat, [FromQuery] string verblijfplaats__postcode)
        //{
        //    throw new NotImplementedException();
        //}

        //public override Task<ActionResult<IngeschrevenPersoonHalBasis>> GetIngeschrevenPersoon(string burgerservicenummer, [FromQuery] string expand, [FromQuery] string fields)
        //{
        //    throw new NotImplementedException();
        //}
    }
}
