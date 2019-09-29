using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using Nop.Core.Domain.Localization;

namespace Nop.Services.Localization
{
    public partial class LocalizationService
    {

        public IList<LocaleStringResource> LoadResourcesFromXml(string xml)
        {
            throw new NotImplementedException();
        }

        public IList<LocaleStringResource> LoadResourcesFromXmlFile(string file)
        {
            //throw new NotImplementedException(); AppContext.BaseDirectory;
            //var doc = XDocument.Load(Environment.CurrentDirectory + @"\" + "Product.xml");
            // System.AppContext.BaseDirectory + @"\" + "Product.xml"
            // 判断 file 是否存在 
            var doc = XDocument.Load(file);
            var root = doc.Element("Language");
            var name = root.Attribute("Name").Value;
            var language = _languageService.GetAllLanguages().FirstOrDefault(l => l.Name == name);

            var query = from p in root.Elements("LocaleResource")
                            //where (int)p.Element("ProductID") == 1
                        select new LocaleStringResource
                        {
                            Language = language,
                            LanguageId = language.Id,
                            ResourceName = p.Attribute("Name").Value,
                            ResourceValue = p.Value
                        };
            return query.ToList();
        }
    }
}
