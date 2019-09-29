using Nop.Core.Infrastructure;
using Nop.Services.Localization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Nop.Services.Installation
{
    public partial class CodeFirstInstallationService
    {
        protected virtual void InstallLocaleResources()
        {
            //'English' language
            var language = _languageRepository.Table.Single(l => l.Name == "English");

            //save resources
            var directoryPath = _fileProvider.MapPath(NopInstallationDefaults.LocalizationResourcesPath);
            var pattern = $"*.{NopInstallationDefaults.LocalizationResourcesFileExtension}";
            foreach (var filePath in _fileProvider.EnumerateFiles(directoryPath, pattern))
            {
                //var localesXml = _fileProvider.ReadAllText(filePath, Encoding.UTF8);
                var localizationService = EngineContext.Current.Resolve<ILocalizationService>();
                //localizationService.ImportResourcesFromXml(language, localesXml);
                var resources = localizationService.LoadResourcesFromXmlFile(filePath);
                _localeStringResourceRepository.Insert(resources);
            }
        }
    }
}
