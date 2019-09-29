using System;
using System.IO;
using System.Linq;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Nop.Core;
using Nop.Core.Caching;
using Nop.Core.Domain.Messages;
using Nop.Plugin.Misc.CodeGenerator.Domain;
using Nop.Plugin.Misc.CodeGenerator.Factories;
using Nop.Plugin.Misc.CodeGenerator.Models;
using Nop.Plugin.Misc.CodeGenerator.Services;
using Nop.Services.Common;
using Nop.Services.Configuration;
using Nop.Services.Localization;
using Nop.Services.Logging;
using Nop.Services.Messages;
using Nop.Services.Security;
using Nop.Services.Stores;
using Nop.Web.Framework;
using Nop.Web.Framework.Controllers;
using Nop.Web.Framework.Models;
using Nop.Web.Framework.Models.Extensions;
using Nop.Web.Framework.Mvc;
using Nop.Web.Framework.Mvc.Filters;
using Nop.Web.Framework.Mvc.ModelBinding;

namespace Nop.Plugin.Misc.CodeGenerator.Controllers
{
    public partial class CodeGeneratorController : BasePluginController
    {
        #region Fields
       
        private readonly ILocalizationService _localizationService;
        private readonly ILogger _logger;
       
        private readonly INotificationService _notificationService;
        private readonly ISettingService _settingService;
        private readonly IStaticCacheManager _cacheManager;
        private readonly IStoreContext _storeContext;
        
        private readonly IStoreService _storeService;
        private readonly IWorkContext _workContext;
        private readonly IPermissionService _permissionService;
        private readonly ICodeGenerateService _codeGenerateService;
        private readonly ICodeGenerateModelFactory _codeGenerateModelFactory;

        #endregion

        #region Ctor

        public CodeGeneratorController(
            ICodeGenerateService codeGenerateService,
            ILocalizationService localizationService,
            IPermissionService permissionService,
            ICodeGenerateModelFactory codeGenerateModelFactory,
            ILogger logger,
           
            INotificationService notificationService,
            ISettingService settingService,
            IStaticCacheManager cacheManager,
            IStoreContext storeContext,
          
            IStoreService storeService,
            IWorkContext workContext
           
            )
        {
            _codeGenerateService = codeGenerateService;
            _localizationService = localizationService;
            _permissionService = permissionService;
            _codeGenerateModelFactory = codeGenerateModelFactory;
            _logger = logger;
           
            _notificationService = notificationService;
            _settingService = settingService;
            _cacheManager = cacheManager;
            _storeContext = storeContext;
           
            _storeService = storeService;
            _workContext = workContext;
       
        }

        #endregion

        #region Utilities

        #endregion

        #region Methods

        //public virtual IActionResult Index()
        //{
        //    if (!_permissionService.Authorize(StandardPermissionProvider.ManageCustomers))
        //        return AccessDeniedView();

        //    //prepare model
        //    var model = _codeGenerateModelFactory.PrepareConfigurationModel(new ConfigurationModel());
        //    return View(model);
        //}

        //[HttpPost]
        //public async Task<IActionResult> GenerateCode(DatabaseSchemaModel model)
        //{
        //    if (!_permissionService.Authorize(StandardPermissionProvider.AccessAdminPanel))
        //        return AccessDeniedView();

        //    var engine = new RazorLightEngineBuilder()
        //      .UseFilesystemProject(AppContext.BaseDirectory)
        //      .UseMemoryCachingProvider()
        //      .Build();
        //    var key = @"F:\dotnet\nop\nop42formysql\Presentation\Nop.Web\Areas\Admin\Views\CodeGenerator\InterfacePopup.cshtml";
        //    string result = await engine.CompileRenderAsync(key, model);


        //    var viewModel = _codeGenerateModelFactory.PrepareDatabaseModel(new DatabaseSchemaModel());
        //    viewModel.Code = result;

        //    return View("Index", viewModel);
        //}

        [AuthorizeAdmin]
        [Area(AreaNames.Admin)]
        public virtual IActionResult InterfacePopup(TableSchemaModel model)
        {
            if (!_permissionService.Authorize(StandardPermissionProvider.ManageCustomers))
                return AccessDeniedView();

            //prepare model
            return View("~/Plugins/Misc.CodeGenerator/Views/InterfacePopup.cshtml", model);
        }
        [AuthorizeAdmin]
        [Area(AreaNames.Admin)]
        public virtual IActionResult ModelPopup(TableSchemaModel model)
        {
            if (!_permissionService.Authorize(StandardPermissionProvider.ManageCustomers))
                return AccessDeniedView();

            var vm = _codeGenerateModelFactory.PrepareTableModel(model);
            return View("~/Plugins/Misc.CodeGenerator/Views/ModelPopup.cshtml", vm);
        }
        // 
        [AuthorizeAdmin]
        [Area(AreaNames.Admin)]
        public virtual IActionResult ServicePopup(TableSchemaModel model)
        {
            if (!_permissionService.Authorize(StandardPermissionProvider.ManageCustomers))
                return AccessDeniedView();

            //prepare model
            return View("~/Plugins/Misc.CodeGenerator/Views/ServicePopup.cshtml", model);
        }

        [AuthorizeAdmin]
        [Area(AreaNames.Admin)]
        public virtual IActionResult ControllerPopup(TableSchemaModel model)
        {
            if (!_permissionService.Authorize(StandardPermissionProvider.ManageCustomers))
                return AccessDeniedView();

            //prepare model
            return View("~/Plugins/Misc.CodeGenerator/Views/ControllerPopup.cshtml", model);
        }

        [AuthorizeAdmin]
        [Area(AreaNames.Admin)]
        public virtual IActionResult ValidatorPopup(TableSchemaModel model)
        {
            if (!_permissionService.Authorize(StandardPermissionProvider.ManageCustomers))
                return AccessDeniedView();

            //prepare model
            var vm = _codeGenerateModelFactory.PrepareTableModel(model);
            return View("~/Plugins/Misc.CodeGenerator/Views/ValidatorPopup.cshtml", vm);
        }

        [AuthorizeAdmin]
        [Area(AreaNames.Admin)]
        public virtual IActionResult ViewPopup(TableSchemaModel model)
        {
            if (!_permissionService.Authorize(StandardPermissionProvider.ManageCustomers))
                return AccessDeniedView();

            //prepare model
            var vm = _codeGenerateModelFactory.PrepareTableModel(model);
            return View("~/Plugins/Misc.CodeGenerator/Views/ViewPopup.cshtml", vm);
        }

        [AuthorizeAdmin]
        [Area(AreaNames.Admin)]
        public virtual IActionResult MapperConfigurationPopup(TableSchemaModel model)
        {
            if (!_permissionService.Authorize(StandardPermissionProvider.ManageCustomers))
                return AccessDeniedView();

            //prepare model
            var vm = _codeGenerateModelFactory.PrepareTableModel(model);
            return View("~/Plugins/Misc.CodeGenerator/Views/MapperConfigurationPopup.cshtml", vm);
        }

        [AuthorizeAdmin]
        [Area(AreaNames.Admin)]
        public virtual IActionResult ResourcePopup(TableSchemaModel model)
        {
            if (!_permissionService.Authorize(StandardPermissionProvider.ManageCustomers))
                return AccessDeniedView();

            //prepare model
            var vm = _codeGenerateModelFactory.PrepareTableModel(model);
            return View("~/Plugins/Misc.CodeGenerator/Views/ResourcePopup.cshtml", vm);
        }

        #endregion
    }
}