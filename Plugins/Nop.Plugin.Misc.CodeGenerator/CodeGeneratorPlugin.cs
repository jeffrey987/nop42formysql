using System.Collections.Generic;
using Nop.Core;
using Nop.Core.Domain.Tasks;
using Nop.Plugin.Misc.CodeGenerator.Data;
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
    /// Represents the SendinBlue plugin
    /// </summary>
    public partial class CodeGeneratorPlugin : BasePlugin, IMiscPlugin, IAdminMenuPlugin
    {
        #region Fields

        private readonly IEmailAccountService _emailAccountService;
        private readonly IGenericAttributeService _genericAttributeService;
        private readonly ILocalizationService _localizationService;
        private readonly IMessageTemplateService _messageTemplateService;
        private readonly IScheduleTaskService _scheduleTaskService;
        private readonly ISettingService _settingService;
        private readonly IStoreService _storeService;
        private readonly IWebHelper _webHelper;
        private readonly IWorkContext _workContext;

        private readonly CodeGeneratorObjectContext _objectContext;

        #endregion

        #region Ctor

        public CodeGeneratorPlugin(IEmailAccountService emailAccountService,
            IGenericAttributeService genericAttributeService,
            ILocalizationService localizationService,
            IMessageTemplateService messageTemplateService,
            IScheduleTaskService scheduleTaskService,
            ISettingService settingService,
            IStoreService storeService,
            IWorkContext workContext,
            IWebHelper webHelper,
            CodeGeneratorObjectContext objectContext)
        {
            _emailAccountService = emailAccountService;
            _genericAttributeService = genericAttributeService;
            _localizationService = localizationService;
            _messageTemplateService = messageTemplateService;
            _scheduleTaskService = scheduleTaskService;
            _settingService = settingService;
            _storeService = storeService;
            _workContext = workContext;
            _webHelper = webHelper;

            _objectContext = objectContext;
        }

        //public void ManageSiteMap(SiteMapNode rootNode)
        //{
        //    throw new System.NotImplementedException();
        //}
        

        #endregion

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

        #endregion
    }
}