using System.Collections.Generic;
using Nop.Core;
using Nop.Core.Domain.Tasks;
using Nop.Services.Cms;
using Nop.Services.Common;
using Nop.Services.Configuration;
using Nop.Services.Localization;
using Nop.Services.Messages;
using Nop.Services.Plugins;
using Nop.Services.Stores;
using Nop.Services.Tasks;
using Nop.Web.Framework.Infrastructure;
using Nop.Web.Framework.Menu;

namespace Nop.Plugin.Misc.CodeGenerator
{
    /// <summary>
    /// Represents the CodeGenerator plugin
    /// </summary>
    public partial class CodeGeneratorPlugin
    {

        #region Methods

        ///// <summary>
        ///// Gets widget zones where this widget should be rendered
        ///// </summary>
        ///// <returns>Widget zones</returns>
        //public IList<string> GetWidgetZones()
        //{
        //    return new List<string> { PublicWidgetZones.HeadHtmlTag };
        //}

        ///// <summary>
        ///// Gets a name of a view component for displaying widget
        ///// </summary>
        ///// <param name="widgetZone">Name of the widget zone</param>
        ///// <returns>View component name</returns>
        //public string GetWidgetViewComponentName(string widgetZone)
        //{
        //    return CodeGeneratorDefaults.TRACKING_VIEW_COMPONENT_NAME;
        //}

        /// <summary>
        /// Gets a configuration page URL
        /// </summary>
        public override string GetConfigurationPageUrl()
        {
            return $"{_webHelper.GetStoreLocation()}Admin/CodeGenerator/Configure";
        }

        /// <summary>
        /// Install the plugin
        /// </summary>
        public override void Install()
        {
            //settings


            //locales
            //_localizationService.AddOrUpdatePluginLocaleResource("Plugins.Misc.CodeGenerator.AccountInfo", "Account info");
            //_localizationService.AddOrUpdatePluginLocaleResource("Plugins.Misc.CodeGenerator.AccountInfo.Hint", "Display account information.");
            //_localizationService.AddOrUpdatePluginLocaleResource("Plugins.Misc.CodeGenerator.ActivateSMTP", "On your CodeGenerator account, the SMTP has not been enabled yet. To request its activation, simply send an email to our support team at contact@sendinblue.com and mention that you will be using the SMTP with the nopCommerce plugin.");
            //_localizationService.AddOrUpdatePluginLocaleResource("Plugins.Misc.CodeGenerator.AddNewSMSNotification", "Add new SMS notification");
            //_localizationService.AddOrUpdatePluginLocaleResource("Plugins.Misc.CodeGenerator.BillingAddressPhone", "Billing address phone number");
        
            base.Install();
        }

        /// <summary>
        /// Uninstall the plugin
        /// </summary>
        public override void Uninstall()
        {
           
            //locales
            //_localizationService.DeletePluginLocaleResource("Plugins.Misc.CodeGenerator.AccountInfo");
            //_localizationService.DeletePluginLocaleResource("Plugins.Misc.CodeGenerator.AccountInfo.Hint");
            //_localizationService.DeletePluginLocaleResource("Plugins.Misc.CodeGenerator.ActivateSMTP");
            //_localizationService.DeletePluginLocaleResource("Plugins.Misc.CodeGenerator.AddNewSMSNotification");
            //_localizationService.DeletePluginLocaleResource("Plugins.Misc.CodeGenerator.BillingAddressPhone");
            //_localizationService.DeletePluginLocaleResource("Plugins.Misc.CodeGenerator.BillingAddressPhone");
            //_localizationService.DeletePluginLocaleResource("Plugins.Misc.CodeGenerator.CustomerPhone");
          

            base.Uninstall();
        }

        public void ManageSiteMap(SiteMapNode rootNode)
        {
            //string pluginMenuName = _localizationService.GetResource("Plugins.Api.Admin.Menu.Title", languageId: _workContext.WorkingLanguage.Id, defaultValue: "API");
            //string settingsMenuName = _localizationService.GetResource("Plugins.Api.Admin.Menu.Settings.Title", languageId: _workContext.WorkingLanguage.Id, defaultValue: "API");
            //string manageClientsMenuName = _localizationService.GetResource("Plugins.Api.Admin.Menu.Clients.Title", languageId: _workContext.WorkingLanguage.Id, defaultValue: "API");

            //const string adminUrlPart = "Admin/";

            //var pluginMainMenu = new SiteMapNode
            //{
            //    Title = pluginMenuName,
            //    Visible = true,
            //    SystemName = "Api-Main-Menu",
            //    IconClass = "fa-genderless"
            //};

            //pluginMainMenu.ChildNodes.Add(new SiteMapNode
            //{
            //    Title = settingsMenuName,
            //    Url = _webHelper.GetStoreLocation() + adminUrlPart + "ApiAdmin/Settings",
            //    Visible = true,
            //    SystemName = "Api-Settings-Menu",
            //    IconClass = "fa-genderless"
            //});

            //pluginMainMenu.ChildNodes.Add(new SiteMapNode
            //{
            //    Title = manageClientsMenuName,
            //    Url = _webHelper.GetStoreLocation() + adminUrlPart + "ManageClientsAdmin/List",
            //    Visible = true,
            //    SystemName = "Api-Clients-Menu",
            //    IconClass = "fa-genderless"
            //});


            //string pluginDocumentationUrl = "https://github.com/SevenSpikes/api-plugin-for-nopcommerce";

            //pluginMainMenu.ChildNodes.Add(new SiteMapNode
            //{
            //    Title = _localizationService.GetResource("Plugins.Api.Admin.Menu.Docs.Title"),
            //    Url = pluginDocumentationUrl,
            //    Visible = true,
            //    SystemName = "Api-Docs-Menu",
            //    IconClass = "fa-genderless"
            //});//TODO: target="_blank"


            //rootNode.ChildNodes.Add(pluginMainMenu);
        }

        #endregion
    }
}