using System;
using System.IO;
using System.Linq;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Nop.Core;
using Nop.Core.Caching;
using Nop.Core.Domain.Messages;
using Nop.Plugin.Misc.CodeGenerator.Models;
using Nop.Plugin.Misc.CodeGenerator.Services;
using Nop.Services.Common;
using Nop.Services.Configuration;
using Nop.Services.Localization;
using Nop.Services.Logging;
using Nop.Services.Messages;
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
    public partial class CodeGeneratorController
    {

        #region Utilities

        /// <summary>
        /// Prepare SendinBlueModel
        /// </summary>
        /// <param name="model">Model</param>
        private void PrepareModel(ConfigurationModel model)
        {
            //load settings for active store scope
            var storeId = _storeContext.ActiveStoreScopeConfiguration;
            var sendinBlueSettings = _settingService.LoadSetting<CodeGeneratorSettings>(storeId);

            //whether plugin is configured
            if (string.IsNullOrEmpty(sendinBlueSettings.ApiKey))
                return;

            //prepare common properties
            model.ActiveStoreScopeConfiguration = storeId;
            model.ApiKey = sendinBlueSettings.ApiKey;
            model.ListId = sendinBlueSettings.ListId;
            model.SmtpKey = sendinBlueSettings.SmtpKey;
            model.SenderId = sendinBlueSettings.SenderId;
            model.UseSmsNotifications = sendinBlueSettings.UseSmsNotifications;
            model.SmsSenderName = sendinBlueSettings.SmsSenderName;
            model.StoreOwnerPhoneNumber = sendinBlueSettings.StoreOwnerPhoneNumber;
            model.UseMarketingAutomation = sendinBlueSettings.UseMarketingAutomation;
            model.TrackingScript = sendinBlueSettings.TrackingScript;

            //model.HideGeneralBlock = _genericAttributeService.GetAttribute<bool>(_workContext.CurrentCustomer, CodeGeneratorDefaults.HideGeneralBlock);
            //model.HideSynchronizationBlock = _genericAttributeService.GetAttribute<bool>(_workContext.CurrentCustomer, CodeGeneratorDefaults.HideSynchronizationBlock);
            //model.HideTransactionalBlock = _genericAttributeService.GetAttribute<bool>(_workContext.CurrentCustomer, CodeGeneratorDefaults.HideTransactionalBlock);
            //model.HideSmsBlock = _genericAttributeService.GetAttribute<bool>(_workContext.CurrentCustomer, CodeGeneratorDefaults.HideSmsBlock);
            //model.HideMarketingAutomationBlock = _genericAttributeService.GetAttribute<bool>(_workContext.CurrentCustomer, CodeGeneratorDefaults.HideMarketingAutomationBlock);

            
            
        }

        #endregion

        #region Methods

        [AuthorizeAdmin]
        [Area(AreaNames.Admin)]
        public IActionResult Configure()
        {
            //var model = new ConfigurationModel();
            //PrepareModel(model);
            var model = _codeGenerateModelFactory.PrepareConfigurationModel(new ConfigurationModel());

            return View("~/Plugins/Misc.CodeGenerator/Views/Configure.cshtml", model);
        }

        [AuthorizeAdmin]
        [Area(AreaNames.Admin)]
        [HttpPost, ActionName("Configure")]
        [FormValueRequired("save")]
        public IActionResult Configure(ConfigurationModel model)
        {
            if (!ModelState.IsValid)
                return Configure();

            var storeId = _storeContext.ActiveStoreScopeConfiguration;
            var sendinBlueSettings = _settingService.LoadSetting<CodeGeneratorSettings>(storeId);

            //set API key
            sendinBlueSettings.ApiKey = model.ApiKey;
            _settingService.SaveSetting(sendinBlueSettings, settings => settings.ApiKey, clearCache: false);
            _settingService.ClearCache();

            _notificationService.SuccessNotification(_localizationService.GetResource("Admin.Plugins.Saved"));

            return Configure();
        }


        #endregion
    }
}