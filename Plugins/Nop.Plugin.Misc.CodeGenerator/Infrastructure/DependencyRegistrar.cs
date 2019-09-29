using Autofac;
using Autofac.Core;
using Nop.Core.Configuration;
using Nop.Core.Data;
using Nop.Core.Infrastructure;
using Nop.Core.Infrastructure.DependencyManagement;
using Nop.Data;
using Nop.Plugin.Misc.CodeGenerator.Data;
using Nop.Plugin.Misc.CodeGenerator.Domain;
using Nop.Plugin.Misc.CodeGenerator.Factories;
using Nop.Plugin.Misc.CodeGenerator.Services;
using Nop.Services.Messages;
using Nop.Web.Framework.Infrastructure.Extensions;

namespace Nop.Plugin.Misc.CodeGenerator.Infrastructure
{
    /// <summary>
    /// Represents a plugin dependency registrar
    /// </summary>
    public class DependencyRegistrar : IDependencyRegistrar
    {
        /// <summary>
        /// Register services and interfaces
        /// </summary>
        /// <param name="builder">Container builder</param>
        /// <param name="typeFinder">Type finder</param>
        /// <param name="config">Config</param>
        public void Register(ContainerBuilder builder, ITypeFinder typeFinder, NopConfig config)
        {
            //register custom services
            //builder.RegisterType<SendinBlueManager>().AsSelf().InstancePerLifetimeScope();
            //builder.RegisterType<SendinBlueMarketingAutomationManager>().AsSelf().InstancePerLifetimeScope();

            //override services
            //builder.RegisterType<SendinBlueMessageService>().As<IWorkflowMessageService>().InstancePerLifetimeScope();
            //builder.RegisterType<SendinBlueEmailSender>().As<IEmailSender>().InstancePerLifetimeScope();
            //data context
            builder.RegisterPluginDataContext<CodeGeneratorObjectContext>("nop_object_context_code_generator");

            //builder.RegisterType<CodeGenerateService>().As<ICodeGenerateService>().InstancePerLifetimeScope();
            builder.RegisterType<CodeGenerateService>().As<ICodeGenerateService>()
                .WithParameter(ResolvedParameter.ForNamed<IDbContext>("nop_object_context_code_generator"))
                .InstancePerLifetimeScope();
            builder.RegisterType<CodeGenerateModelFactory>().As<ICodeGenerateModelFactory>().InstancePerLifetimeScope();

            //override required repository with our custom context
            //builder.RegisterType<EfRepository<ColumnSchema>>().As<IRepository<ColumnSchema>>()
            //    .WithParameter(ResolvedParameter.ForNamed<IDbContext>("nop_object_context_code_generator"))
            //    .InstancePerLifetimeScope();
        }

        /// <summary>
        /// Order of this dependency registrar implementation
        /// </summary>
        public int Order => 2;
    }
}