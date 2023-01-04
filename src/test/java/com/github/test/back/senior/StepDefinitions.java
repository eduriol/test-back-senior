package com.github.test.back.senior;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import static io.restassured.RestAssured.given;

public class StepDefinitions {

    private RequestSpecification requestSpec;
    private Response response;

    @Given("I have an account with access to the Contacts API")
    public void iHaveAnAccountWithAccessToTheContactsAPI() throws IOException {
        Properties prop = new Properties();
        InputStream input = getClass().getResourceAsStream("/test.properties");
        prop.load(input);
        String baseUri = prop.getProperty("base_uri");
        String basePath = prop.getProperty("base_path");
        String authToken = System.getenv("AUTH_TOKEN");
        requestSpec = given()
                .baseUri(baseUri)
                .basePath(basePath)
                .header("Authorization", "Basic " + authToken);
    }

    @When("I search for the contact with phone number {string}")
    public void iSearchForTheContactWithPhoneNumber(String phoneNumber) {
        response = requestSpec
                .when()
                .queryParam("phone_number", phoneNumber)
                .get();
    }

    @Then("I get a successful response")
    public void iGetASuccessfulResponse() {
        response
                .then()
                .statusCode(200);
    }
}
