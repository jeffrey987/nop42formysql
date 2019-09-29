using Nop.Plugin.Misc.CodeGenerator.Domain;
using Nop.Plugin.Misc.CodeGenerator.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Nop.Plugin.Misc.CodeGenerator.Factories
{
    public interface ICodeGenerateModelFactory
    {
        ConfigurationModel PrepareConfigurationModel(ConfigurationModel model);

        TableSchemaModel PrepareTableModel(TableSchemaModel entity);
    }
}
