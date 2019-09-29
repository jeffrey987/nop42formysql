using Microsoft.AspNetCore.Mvc.Rendering;
using Nop.Web.Framework.Models;
using Nop.Web.Framework.Mvc.ModelBinding;
using System;
using System.Collections.Generic;
using System.Text;

namespace Nop.Plugin.Api.Models.Admin
{
    //class ClientSearchModel
    //{
    //}
    // Nop.Web.Areas.Admin.Models.Customers

    public partial class ClientSearchModel : BaseSearchModel //, IAclSupportedModel
    {
        #region Ctor

        public ClientSearchModel()
        {
            
        }

        #endregion

        #region Properties


        [NopResourceDisplayName("Admin.Api.Clients.List.ClientName")]
        public string SearchClientName { get; set; }

        [NopResourceDisplayName("Admin.Api.Clients.List.ClientId")]
        public string SearchClientId { get; set; }


        #endregion
    }
}
