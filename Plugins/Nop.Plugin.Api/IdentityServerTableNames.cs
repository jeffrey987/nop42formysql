using System;
using System.Collections.Generic;
using System.Text;

namespace Nop.Plugin.Api
{
    public static partial class IdentityServerTableNames
    {
        public static class Client
        {
            public const string Clients                      = "oidc_clients";
            public const string ClientClaims                 = "oidc_client_claims";
            public const string ClientCorsOrigins            = "oidc_client_cors_origins";
            public const string ClientGrantTypes             = "oidc_client_grant_types";
            public const string ClientIdPRestrictions        = "oidc_client_idp_restrictions";
            public const string ClientPostLogoutRedirectUris = "oidc_client_post_logout_redirect_uris";
            public const string ClientProperties             = "oidc_client_properties";
            public const string ClientRedirectUris           = "oidc_client_redirect_uris";
            public const string ClientScopes                 = "oidc_client_scopes";
            public const string ClientSecrets                = "oidc_client_secrets";
        }

        public static class ApiResource
        {
            public const string ApiResources   = "oidc_api_resources";
            public const string ApiClaims      = "oidc_api_resource_claims";
            public const string ApiScopes      = "oidc_api_resource_scopes";
            public const string ApiScopeClaims = "oidc_api_resource_scope_claims";
            public const string ApiSecrets     = "oidc_api_resource_secrets";
            public const string ApiResourceProperty = "oidc_api_resource_properties";

        }
        public static class IdentityResource
        {
            public const string IdentityClaims    = "oidc_identity_resource_claims";
            public const string IdentityResources = "oidc_identity_resources";
            public const string IdentityResourceProperty = "oidc_identity_resource_properties";
            
        }
        public static class PersistedGrant
        {
            public const string PersistedGrants = "oidc_persisted_grants";
        }
        public static class DeviceFlowCode
        {
            public const string DeviceFlowCodes = "oidc_device_codess";
        }
    }
}
