using Microsoft.AspNetCore.Mvc.Rendering;
using Nop.Plugin.Misc.CodeGenerator.Domain;
using Nop.Plugin.Misc.CodeGenerator.Models;
using Nop.Plugin.Misc.CodeGenerator.Services;
using Nop.Services;
using System;
using System.Collections.Generic;
using System.Text;

namespace Nop.Plugin.Misc.CodeGenerator.Factories
{
    //class CodeGenerateModelFactory
    //{
    //}
    public partial class CodeGenerateModelFactory : ICodeGenerateModelFactory
    {
        #region Fields

        private readonly ICodeGenerateService _codeGenerateService;

        #endregion

        #region Ctor

        public CodeGenerateModelFactory(ICodeGenerateService codeGenerateService)
        {
            _codeGenerateService = codeGenerateService;
        }

        #endregion
        public virtual ConfigurationModel PrepareConfigurationModel(ConfigurationModel model)
        {
            //var model = _codeGenerateService.GetDatabaseModel();
            model.Tables = _codeGenerateService.GetTables();
            var availableGenerateCodeTypeItems = GenerateCodeType.Interface.ToSelectList(false);
            foreach (var item in availableGenerateCodeTypeItems)
            {
                model.AvailableGenerateCodeTypes.Add(item);
            }

            return model;
        }

        public virtual void PrepareGenerateCodeTypes(IList<SelectListItem> items, bool withSpecialDefaultItem = true, string defaultItemText = null)
        {
            if (items == null)
                throw new ArgumentNullException(nameof(items));

            //prepare available log levels
            var availableGenerateCodeTypeItems = GenerateCodeType.Interface.ToSelectList(false);
            foreach (var item in availableGenerateCodeTypeItems)
            {
                items.Add(item);
            }

            //insert special item for the default value
            // PrepareDefaultItem(items, withSpecialDefaultItem, defaultItemText);
        }

        public virtual TableSchemaModel PrepareTableModel(TableSchemaModel entity)
        {
            var model = new TableSchemaModel
            {
                TableName = entity.TableName,
                CurrentEntityName = entity.CurrentEntityName,
                PluralForms = entity.PluralForms,
                Camelization = entity.Camelization

            };
            model.Columns = _codeGenerateService.GetColumns(model.TableName);
            return model;
        }

    }
}
