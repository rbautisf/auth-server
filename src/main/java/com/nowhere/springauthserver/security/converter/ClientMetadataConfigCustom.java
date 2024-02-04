package com.nowhere.springauthserver.security.converter;

import java.util.List;
import java.util.function.Consumer;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.oauth2.server.authorization.oidc.authentication.OidcClientConfigurationAuthenticationProvider;
import org.springframework.security.oauth2.server.authorization.oidc.authentication.OidcClientRegistrationAuthenticationProvider;

public class ClientMetadataConfigCustom {
    /**
     * Configure custom client metadata converters for OidcClientRegistrationAuthenticationProvider and
     * OidcClientConfigurationAuthenticationProvider.
     * For more details on the client metadata please refer to the following link: https://openid.net/specs/openid-connect-registration-1_0.html#ClientMetadata
     *
     *
     * @return Consumer<List < AuthenticationProvider>>
     */
    public static Consumer<List<AuthenticationProvider>> configureCustomClientMetadataConverters() {
        List<String> customClientMetadata = List.of("logo_uri", "contacts","application_type","environment");

        RegisteredClientConverterCustom registeredClientConverter =
                new RegisteredClientConverterCustom(customClientMetadata);
        ClientRegistrationConverterCustom clientRegistrationConverter =
                new ClientRegistrationConverterCustom(customClientMetadata);

        return (authenticationProviders) -> {
            authenticationProviders.forEach(authProvider -> {
                // switch pattern matching java 21 feature
                switch(authProvider){
                    case OidcClientRegistrationAuthenticationProvider provider -> {
                        provider.setRegisteredClientConverter(registeredClientConverter);
                        provider.setClientRegistrationConverter(clientRegistrationConverter);
                    }
                    case OidcClientConfigurationAuthenticationProvider provider ->
                            provider.setClientRegistrationConverter(clientRegistrationConverter);
                    default -> {}
                }
            });
        };
    }

}
