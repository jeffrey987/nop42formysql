using Nop.Core.Data.Extensions;
using Nop.Core.Domain.Customers;
using System.Collections.Generic;

namespace Nop.Services.Catalog
{
    public partial class ProductTagService
    {
        #region Utilities

        /// <summary>
        /// Get product count for each of existing product tag
        /// </summary>
        /// <param name="storeId">Store identifier</param>
        /// <param name="showHidden">A value indicating whether to show hidden records</param>
        /// <returns>Dictionary of "product tag ID : product count"</returns>
        private Dictionary<int, int> GetProductCount(int storeId, bool showHidden)
        {
            string allowedCustomerRolesIds = "";
            if (!showHidden && !_catalogSettings.IgnoreAcl)
            {
                //Access control list. Allowed customer roles
                //pass customer role identifiers as comma-delimited string
                allowedCustomerRolesIds = string.Join(",", _workContext.CurrentCustomer.GetCustomerRoleIds());
            }

            var key = string.Format(NopCatalogDefaults.ProductTagCountCacheKey, storeId, allowedCustomerRolesIds, showHidden);
            return _staticCacheManager.Get(key, () =>
            {
                //prepare input parameters
                var pStoreId = _dataProvider.GetInt32Parameter("StoreId", storeId);
                var pAllowedCustomerRoleIds = _dataProvider.GetStringParameter("AllowedCustomerRoleIds", allowedCustomerRolesIds);

                return new Dictionary<int, int>();
                //invoke stored procedure
                //return _dbContext.QueryFromSql<ProductTagWithCount>("ProductTagCountLoadAll",
                //        pStoreId,
                //        pAllowedCustomerRoleIds)
                //    .ToDictionary(item => item.ProductTagId, item => item.ProductCount);
            });
        }

        #endregion
    }
}
