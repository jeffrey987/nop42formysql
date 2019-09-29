using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Routing;
using Nop.Web.Framework.Mvc.Routing;
namespace Nop.Plugin.Payments.WeChatPay
{
    public partial class RouteProvider : IRouteProvider
    {
        /// <summary>
        /// Register routes
        /// </summary>
        /// <param name="routeBuilder">Route builder</param>
        public void RegisterRoutes(IRouteBuilder routeBuilder)
        {
            //WeChatScanCode
            routeBuilder.MapRoute(WeChatPayDefaults.ScanCodeRouteName,
                 "Plugins/PaymentWeChatPay/WeChatScanCode/{ordercode}",
                 new { controller = "PaymentWeChatPay", action = "WeChatScanCode" }
                 //new[] { "Nop.Plugin.Payments.WeChatPay.Controllers" }
            );
            //MakePayQRCode
            routeBuilder.MapRoute(WeChatPayDefaults.GenerateQRCodeRouteName,
                 "Plugins/PaymentWeChatPay/MakeQRCode",
                 new { controller = "PaymentWeChatPay", action = "MakeQRCode" }
                 //new[] { "Nop.Plugin.Payments.WeChatPay.Controllers" }
            );

            //Notify
            routeBuilder.MapRoute(WeChatPayDefaults.NotifyRouteName,
                 "Plugins/PaymentWeChatPay/Notify",
                 new { controller = "PaymentWeChatPay", action = "Notify" }
                 //new[] { "Nop.Plugin.Payments.WeChatPay.Controllers" }
            );

            //Return
            routeBuilder.MapRoute("Plugin.Payments.WeChatPay.Return",
                 "Plugins/PaymentWeChatPay/Return",
                 new { controller = "PaymentWeChatPay", action = "Return" }
                 //new[] { "Nop.Plugin.Payments.WeChatPay.Controllers" }
            );

            routeBuilder.MapRoute(WeChatPayDefaults.RefundNotifyRouteName,
                 "Plugins/PaymentWeChatPay/RefundNotify",
                 new { controller = "PaymentWeChatPay", action = "RefundNotify" }
                 //new[] { "Nop.Plugin.Payments.WeChatPay.Controllers" }
            );

        }

        /// <summary>
        /// Gets a priority of route provider
        /// </summary>
        public int Priority
        {
            get { return -1; }
        }
    }
}
