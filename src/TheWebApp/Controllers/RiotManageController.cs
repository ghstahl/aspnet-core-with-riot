using Microsoft.AspNetCore.Mvc;

namespace TheWebApp.Controllers
{
    public class RiotManageController : Controller
    {
        public IActionResult Index()
        {
            // TODO: You will have access to a OIDC of the user in our session if you get here.
            // Fetch the OIDC and pass it to your view
            return View();
        }
    }
}