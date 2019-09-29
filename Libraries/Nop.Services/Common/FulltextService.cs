using System.Linq;
using Nop.Core.Data;
using Nop.Core.Domain.Common;
using Nop.Data;

namespace Nop.Services.Common
{
    /// <summary>
    /// Full-Text service
    /// </summary>
    public partial class FulltextService : IFulltextService
    {
        #region Fields

        private readonly IDbContext _dbContext;

        #endregion

        #region Ctor

        public FulltextService(IDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        #endregion

        #region Methods

        /// <summary>
        /// Gets value indicating whether Full-Text is supported
        /// </summary>
        /// <returns>Result</returns>
        public virtual bool IsFullTextSupported()
        {
            var result = 0;
            var dataSettings = DataSettingsManager.LoadSettings();

            switch (dataSettings.DataProvider)
            {
                case DataProviderType.Unknown:
                case DataProviderType.SqlServer:
                    var x = _dbContext
                            .QueryFromSql<IntQueryType>("EXEC [FullText_IsSupported]")
                            .Select(intValue => intValue.Value).FirstOrDefault();
                    result = x.HasValue ? x.Value : 0;
                    break;
                case DataProviderType.MySql:
                    break;
                case DataProviderType.PostgreSql:
                    break;
                default:
                    break;
            }
            return result > 0;
        }

        /// <summary>
        /// Enable Full-Text support
        /// </summary>
        public virtual void EnableFullText()
        {
            var dataSettings = DataSettingsManager.LoadSettings();

            switch (dataSettings.DataProvider)
            {
                case DataProviderType.Unknown:
                case DataProviderType.SqlServer:
                    _dbContext.ExecuteSqlCommand("EXEC [FullText_Enable]", true);
                    break;
                case DataProviderType.MySql:
                    break;
                case DataProviderType.PostgreSql:
                    break;
                default:
                    break;
            }
            
        }

        /// <summary>
        /// Disable Full-Text support
        /// </summary>
        public virtual void DisableFullText()
        {
            var dataSettings = DataSettingsManager.LoadSettings();

            switch (dataSettings.DataProvider)
            {
                case DataProviderType.Unknown:
                case DataProviderType.SqlServer:
                    _dbContext.ExecuteSqlCommand("EXEC [FullText_Disable]", true);
                    break;
                case DataProviderType.MySql:
                    break;
                case DataProviderType.PostgreSql:
                    break;
                default:
                    break;
            }
            
        }

        #endregion
    }
}