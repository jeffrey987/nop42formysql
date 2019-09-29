using System;
using System.Collections.Generic;
using System.IO;
using System.Linq.Expressions;
using Nop.Core;
using Nop.Core.Configuration;
using Nop.Core.Domain.Localization;
using Nop.Core.Domain.Security;
using Nop.Services.Plugins;

namespace Nop.Services.Localization
{
    /// <summary>
    /// Localization manager interface
    /// </summary>
    public partial interface ILocalizationService
    {
        // == husb

        
        IList<LocaleStringResource> LoadResourcesFromXml(string xml);
        IList<LocaleStringResource> LoadResourcesFromXmlFile(string file);
    }
}