using Microsoft.AspNetCore.Mvc.Rendering;
using Nop.Web.Framework.Mvc.ModelBinding;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Nop.Web.Areas.Admin.Models.Common
{
    public partial class DatabaseSchemaModel
    {
        public string TableName { get; set; }

        [NopResourceDisplayName("Admin.Systems.Fields.Code")]
        public string CurrentEntityName { get; set; }

        public string PluralForms { get; set; }

        public string Pascalization { get; set; }

        public string Camelization { get; set; }

        public string Code { get; set; }
        public GenerateCodeType GenerateCodeType { set; get; }

        [NopResourceDisplayName("Admin.System.Log.List.LogLevel")]
        public int GenerateCodeTypeId { get; set; }

        private IList<SelectListItem> _generateCodeTypes;
        //public IList<SelectListItem> AvailableGenerateCodeTypes { get; set; }
        public IList<SelectListItem> AvailableGenerateCodeTypes
        {
            get => _generateCodeTypes ?? (_generateCodeTypes = new List<SelectListItem>());
            set => _generateCodeTypes = value;
        }

        private IList<string> _tables;
      
        [NopResourceDisplayName("Admin.SystemUser.Fields.UserRoles")]
        public virtual IList<string> Tables
        {
            get => _tables ?? (_tables = new List<string>());
            set => _tables = value;
        }

    }

    public enum GenerateCodeType
    {
        /// <summary>
        /// 
        /// </summary>
        Interface = 10,
        /// <summary>
        /// 
        /// </summary>
        Service = 20,
        /// <summary>
        /// 正常部门
        /// </summary>
        Model = 30,

        Controller = 40,

        Validator = 50,

        View = 60,

        MapperConfiguration = 70,

        Resource = 80
    }
}
