using IdentityServer4.EntityFramework.Entities;
using Nop.Plugin.Api.Models;
using Nop.Plugin.Api.Models.Admin;
using System;
using System.Collections.Generic;
using System.Text;

namespace Nop.Plugin.Api.Factories
{


    public partial interface IClientModelFactory
    {
        /// <summary>
        /// Prepare country search model
        /// </summary>
        /// <param name="searchModel">Country search model</param>
        /// <returns>Country search model</returns>
        ClientSearchModel PrepareClientSearchModel(ClientSearchModel searchModel);

        /// <summary>
        /// Prepare paged country list model
        /// </summary>
        /// <param name="searchModel">Country search model</param>
        /// <returns>Country list model</returns>
        ClientListModel PrepareClientListModel(ClientSearchModel searchModel);

        /// <summary>
        /// Prepare country model
        /// </summary>
        /// <param name="model">Country model</param>
        /// <param name="country">Country</param>
        /// <param name="excludeProperties">Whether to exclude populating of some properties of model</param>
        /// <returns>Country model</returns>
        ClientApiModel PrepareClientModel(ClientApiModel model, Client client, bool excludeProperties = false);

       
    }
}
