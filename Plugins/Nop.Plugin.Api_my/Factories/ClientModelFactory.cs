using IdentityServer4.EntityFramework.Entities;
using Nop.Plugin.Api.Models;
using Nop.Plugin.Api.Models.Admin;
using Nop.Plugin.Api.Services;
using Nop.Services.Localization;
using Nop.Web.Framework.Factories;
using System;
using System.Collections.Generic;
using System.Text;
using Nop.Web.Framework.Models.Extensions;
using System.Linq;

namespace Nop.Plugin.Api.Factories
{

    public partial class ClientModelFactory : IClientModelFactory
    {
        #region Fields

        private readonly IClientService _clientService;
        private readonly ILocalizationService _localizationService;
        private readonly ILocalizedModelFactory _localizedModelFactory;
        private readonly IStoreMappingSupportedModelFactory _storeMappingSupportedModelFactory;
      
        #endregion

        #region Ctor

        public ClientModelFactory(IClientService clientService,
            ILocalizationService localizationService,
            ILocalizedModelFactory localizedModelFactory,
            IStoreMappingSupportedModelFactory storeMappingSupportedModelFactory)
        {
            _clientService = clientService;
            _localizationService = localizationService;
            _localizedModelFactory = localizedModelFactory;
            _storeMappingSupportedModelFactory = storeMappingSupportedModelFactory;
            
        }

        #endregion

        #region Utilities

        

        #endregion

        #region Methods

        
        
        /// <summary>
        /// Prepare country model
        /// </summary>
        /// <param name="model">Country model</param>
        /// <param name="country">Country</param>
        /// <param name="excludeProperties">Whether to exclude populating of some properties of model</param>
        /// <returns>Country model</returns>
        //public virtual CountryModel PrepareCountryModel(CountryModel model, Country country, bool excludeProperties = false)
        //{
        //    Action<CountryLocalizedModel, int> localizedModelConfiguration = null;

        //    if (country != null)
        //    {
        //        //fill in model values from the entity
        //        if (model == null)
        //        {
        //            model = country.ToModel<CountryModel>();
        //            model.NumberOfStates = country.StateProvinces?.Count ?? 0;
        //        }

        //        //prepare nested search model
        //        PrepareStateProvinceSearchModel(model.StateProvinceSearchModel, country);

        //        //define localized model configuration action
        //        localizedModelConfiguration = (locale, languageId) =>
        //        {
        //            locale.Name = _localizationService.GetLocalized(country, entity => entity.Name, languageId, false, false);
        //        };
        //    }

        //    //set default values for the new model
        //    if (country == null)
        //    {
        //        model.Published = true;
        //        model.AllowsBilling = true;
        //        model.AllowsShipping = true;
        //    }

        //    //prepare localized models
        //    if (!excludeProperties)
        //        model.Locales = _localizedModelFactory.PrepareLocalizedModels(localizedModelConfiguration);

        //    //prepare available stores
        //    _storeMappingSupportedModelFactory.PrepareModelStores(model, country, excludeProperties);

        //    return model;
        //}

        public ClientSearchModel PrepareClientSearchModel(ClientSearchModel searchModel)
        {
            if (searchModel == null)
                throw new ArgumentNullException(nameof(searchModel));

            //prepare page parameters
            searchModel.SetGridPageSize();

            return searchModel;
        }

        public ClientListModel PrepareClientListModel(ClientSearchModel searchModel)
        {
            if (searchModel == null)
                throw new ArgumentNullException(nameof(searchModel));

            //get countries
            var clients = _clientService.GetAllClients().ToPagedList(searchModel);

            //prepare list model
            var model = new ClientListModel().PrepareToGrid(searchModel, clients, () =>
            {
                //fill in model values from the entity
                return clients.Select(client =>
                {
                    //var countryModel = client.ToModel<CountryModel>();
                    //countryModel.NumberOfStates = client.StateProvinces?.Count ?? 0;

                    return client;
                });
            });

            return model;
        }

        public ClientApiModel PrepareClientModel(ClientApiModel model, Client client, bool excludeProperties = false)
        {
            throw new NotImplementedException();
        }



        #endregion
    }
}
