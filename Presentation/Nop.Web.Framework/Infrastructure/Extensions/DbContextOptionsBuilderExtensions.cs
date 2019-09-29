using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Nop.Core.Configuration;
using Nop.Core.Data;

namespace Nop.Web.Framework.Infrastructure.Extensions
{
    /// <summary>
    /// Represents extensions of DbContextOptionsBuilder
    /// </summary>
    public static class DbContextOptionsBuilderExtensions
    {
        /// <summary>
        /// SQL Server specific extension method for Microsoft.EntityFrameworkCore.DbContextOptionsBuilder
        /// </summary>
        /// <param name="optionsBuilder">Database context options builder</param>
        /// <param name="services">Collection of service descriptors</param>
        public static void UseSqlServerWithLazyLoading(this DbContextOptionsBuilder optionsBuilder, IServiceCollection services)
        {
            var nopConfig = services.BuildServiceProvider().GetRequiredService<NopConfig>();

            var dataSettings = DataSettingsManager.LoadSettings();
            if (!dataSettings?.IsValid ?? true)
                return;

            var dbContextOptionsBuilder = optionsBuilder.UseLazyLoadingProxies();

            //if (nopConfig.UseRowNumberForPaging)
            //    dbContextOptionsBuilder.UseSqlServer(dataSettings.DataConnectionString, option => option.UseRowNumberForPaging());
            //else
            //    dbContextOptionsBuilder.UseSqlServer(dataSettings.DataConnectionString);
            // == husb
            switch (dataSettings.DataProvider)
            {
                case DataProviderType.Unknown:
                    break;
                case DataProviderType.SqlServer:
                    if (nopConfig.UseRowNumberForPaging)
                        dbContextOptionsBuilder.UseSqlServer(dataSettings.DataConnectionString, option => option.UseRowNumberForPaging());
                    else
                        dbContextOptionsBuilder.UseSqlServer(dataSettings.DataConnectionString);
                    break;
                case DataProviderType.MySql:
                    if (nopConfig.UseRowNumberForPaging)
                    {
                        dbContextOptionsBuilder.UseMySql(dataSettings.DataConnectionString, option => { });
                    }
                    else
                    {
                        dbContextOptionsBuilder.UseMySql(dataSettings.DataConnectionString);
                    }
                    break;
                case DataProviderType.PostgreSql:
                    break;
                default:
                    break;
            }
        }
    }
}
