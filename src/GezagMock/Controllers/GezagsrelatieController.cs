using Brp.Gezag.Mock.Generated;
using GezagMock.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace GezagMock.Controllers
{
    public class GezagsrelatieController : Brp.Gezag.Mock.Generated.ControllerBase
    {
        private readonly GezagsrelatieRepository _repository;

        public GezagsrelatieController(GezagsrelatieRepository repository)
        {
            _repository = repository;
        }
        public override async Task<ActionResult<ICollection<Gezagsrelatie>>> OpvragenBevoegdheidTotGezag([FromHeader] string oIN, [FromBody] GezagRequest body)
        {
            var retval = await _repository.Zoek(body.Bsn);

            return Ok(retval);
        }

        public override async Task<ActionResult<ICollection<Gezagsrelatie>>> OpvragenBevoegdheidTotGezagMeerderjarige([FromHeader] string oIN, [FromBody] GezagRequest body)
        {
            var retval = await _repository.Zoek(body.Bsn);

            return Ok(retval);
        }

        public override async Task<ActionResult<ICollection<Gezagsrelatie>>> OpvragenBevoegdheidTotGezagMinderjarige([FromHeader] string oIN, [FromBody] GezagRequest body)
        {
            var retval = await _repository.Zoek(body.Bsn);

            return Ok(retval);
        }
    }
}
