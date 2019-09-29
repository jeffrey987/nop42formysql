using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc.Rendering;
using Nop.Plugin.Misc.CodeGenerator.Domain;
using Nop.Web.Framework.Models;
using Nop.Web.Framework.Mvc.ModelBinding;

namespace Nop.Plugin.Misc.CodeGenerator.Models
{
    /// <summary>
    /// Represents a configuration model
    /// </summary>
    public partial class ConfigurationModel
    {
        public GenerateCodeType GenerateCodeType { set; get; }

        //[NopResourceDisplayName("Admin.System.Log.List.LogLevel")]
        public int GenerateCodeTypeId { get; set; }

        private IList<SelectListItem> _generateCodeTypes;
        //public IList<SelectListItem> AvailableGenerateCodeTypes { get; set; }
        public IList<SelectListItem> AvailableGenerateCodeTypes
        {
            get => _generateCodeTypes ?? (_generateCodeTypes = new List<SelectListItem>());
            set => _generateCodeTypes = value;
        }

        private IList<TableSchema> _tables;

        //[NopResourceDisplayName("Admin.SystemUser.Fields.UserRoles")]
        public virtual IList<TableSchema> Tables
        {
            get => _tables ?? (_tables = new List<TableSchema>());
            set => _tables = value;
        }


        public string TableName { get; set; }

        //[NopResourceDisplayName("Admin.Systems.Fields.Code")]
        public string CurrentEntityName { get; set; }

        public string PluralForms { get; set; }

        public string Pascalization { get; set; }

        public string Camelization { get; set; }

        public string Code { get; set; }


    }
}