using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace TheWebApp.Controllers
{
    [Area("Api")]
    [Route("api/[controller]")]

    public class AntiforgeryController : Controller
    {
        [Route("ImportantData")]
        [ValidateAntiForgeryToken]
        public async Task PostImportantData()
        {

        }
        [Route("UnimportantData")]
        public async Task PostUnimportantData()
        {

        }
    }
}