package com.nowhere.springauthserver.security.converter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;
import org.springframework.core.convert.converter.Converter;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClient;
import org.springframework.security.oauth2.server.authorization.oidc.OidcClientRegistration;
import org.springframework.security.oauth2.server.authorization.oidc.converter.RegisteredClientOidcClientRegistrationConverter;
import org.springframework.security.oauth2.server.authorization.settings.ClientSettings;
import org.springframework.util.CollectionUtils;

/**
 * ClientRegistrationConverterCustom is a custom converter for RegisteredClient to OidcClientRegistration.
 * It extends the RegisteredClientOidcClientRegistrationConverter and adds custom client metadata to the claims.
 */
public class ClientRegistrationConverterCustom implements Converter<RegisteredClient, OidcClientRegistration> {

    private final List<String> customClientMetadata;
    private final RegisteredClientOidcClientRegistrationConverter delegate;

    public ClientRegistrationConverterCustom(List<String> customClientMetadata, RegisteredClientOidcClientRegistrationConverter delegate) {
        this.customClientMetadata = customClientMetadata;
        this.delegate = delegate;
    }

    @Override
    public OidcClientRegistration convert(RegisteredClient registeredClient) {
        OidcClientRegistration clientRegistration = this.delegate.convert(registeredClient);
        assert clientRegistration != null;
        Map<String, Object> claims = new HashMap<>(clientRegistration.getClaims());
        if (!CollectionUtils.isEmpty(this.customClientMetadata)) {
            // Create a new client settings object with the custom client metadata
            ClientSettings clientSettings = registeredClient.getClientSettings();

            claims.putAll(this.customClientMetadata.stream()
                    .filter(metadata -> clientSettings.getSetting(metadata) != null)
                    .collect(
                            Collectors.toMap(
                                    Function.identity(), clientSettings::getSetting
                            )
                    )
            );
        }

        return OidcClientRegistration.withClaims(claims).build();
    }

}