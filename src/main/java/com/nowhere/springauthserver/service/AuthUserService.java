package com.nowhere.springauthserver.service;

import com.nowhere.springauthserver.persistence.entity.AuthUser;
import java.util.Set;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

public interface AuthUserService {
    AuthUser createUser(String username, String password, Set<String> roles) throws IllegalArgumentException;

    AuthUser getByUsername(String username) throws UsernameNotFoundException;

    void createUserIfNotExists(String username);
}
