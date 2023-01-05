package com.github.test.back.senior;

import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class TestConfigurator {

    public Map<String, String> getTestConfiguration() throws IOException {
        Properties properties = new Properties();
        InputStream input = getClass().getResourceAsStream("/test.properties");
        properties.load(input);
        Map<String, String> configuration = new HashMap<>();
        configuration.put("base_uri", properties.getProperty("base_uri"));
        configuration.put("base_path", properties.getProperty("base_path"));
        configuration.put("auth_token", getAuthTokenFromEnv());
        return configuration;
    }

    private String getAuthTokenFromEnv() {
        String appId = System.getenv("API_ID");
        String appToken = System.getenv("API_TOKEN");
        String authString = appId + ":" + appToken;
        return Base64.getEncoder().encodeToString(authString.getBytes());
    }
}
