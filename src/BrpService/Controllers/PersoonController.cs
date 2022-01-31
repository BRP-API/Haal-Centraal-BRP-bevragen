using HaalCentraal.BrpService.Generated;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HaalCentraal.BrpService.Controllers
{
    [ApiController]
    public class PersoonController : Generated.ControllerBase
    {
        public override async Task<ActionResult<IngeschrevenPersoonBeperktHalCollectie>> GetIngeschrevenPersonen([Microsoft.AspNetCore.Mvc.FromBody] ZoekPersonenQuery body)
        {
            return Ok(new IngeschrevenPersoonBeperktHalCollectie
            {
                _links = new HalCollectionLinks
                {
                    Self = new HalLink { Href = this.ControllerContext.HttpContext.Request.Path }
                },
                _embedded = new IngeschrevenPersoonBeperktHalCollectieEmbedded
                {
                    Ingeschrevenpersonen = new List<IngeschrevenPersoonBeperktHal>
                     {
                         new IngeschrevenPersoonBeperktHal
                         {
                             Geboortedatum = new GbaDatum { Waarde = "20210124" }
                         },
                         new IngeschrevenPersoonBeperktHal
                         {
                             Geboortedatum = new GbaDatum { Waarde = "20210100" }
                         },
                         new IngeschrevenPersoonBeperktHal
                         {
                             Geboortedatum = new GbaDatum { Waarde = "20210000" }
                         },
                         new IngeschrevenPersoonBeperktHal
                         {
                             Geboortedatum = new GbaDatum { Waarde = "00000000" }
                         }
                     }
                }
            });
        }

        public override Task<ActionResult<IngeschrevenPersoonHal>> GetIngeschrevenPersoon(Guid persoonIdentificatie, [FromQuery] string fields)
        {
            throw new NotImplementedException();
        }
    }
}
