using Microsoft.AspNetCore.Mvc;
using Nop.Services.Security;
using Nop.Web.Framework.Mvc.Filters;
using Nop.Web.Framework.Security;

namespace Nop.Web.Controllers
{
    public partial class HomeController : BasePublicController
    {
        //[HttpsRequirement(SslRequirement.No)]
        //public virtual IActionResult Index()
        //{
        //    return View();
        //}

        private readonly IPermissionService _permissionService;

        public HomeController(
           IPermissionService permissionService
           )
        {
            _permissionService = permissionService;
        }
        [HttpsRequirement(SslRequirement.No)]
        public virtual IActionResult Index()
        {
            //if (_permissionService.Authorize(StandardPermissionProvider.AccessAdminPanel))
            //    return RedirectToRoute("AdminPanel");

            return View();
        }

    }
}