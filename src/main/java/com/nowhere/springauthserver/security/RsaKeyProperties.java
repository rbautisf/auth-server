package com.nowhere.springauthserver.security;

import org.springframework.boot.context.properties.ConfigurationProperties;

import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;

@ConfigurationProperties(prefix = SecurityConstants.RSA_KEY_PROPERTIES_PREFIX)
public record RsaKeyProperties(RSAPublicKey publicKey, RSAPrivateKey privateKey) {
    public RsaKeyProperties {
        if (publicKey == null || privateKey == null) {
            throw new IllegalArgumentException("Public and private keys are required");
        }
    }
}
