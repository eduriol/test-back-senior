package com.github.test.back.senior;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.io.IOException;
import java.util.Map;

import static io.restassured.RestAssured.given;

public class StepDefinitions {

    private RequestSpecification requestSpec;
    private Response response;

    @Given("I have an account with access to the Contacts API")
    public void iHaveAnAccountWithAccessToTheContactsAPI() throws IOException {
        Configurator configurator = new Configurator();
        Map<String, String> configuration = configurator.getTestConfiguration();
        requestSpec = given()
                .baseUri(configuration.get("base_uri"))
                .basePath(configuration.get("base_path"))
                .header("Authorization", "Basic " + configuration.get("auth_token"));
    }

    @When("I search for the contact with phone number {string}")
    public void iSearchForTheContactWithPhoneNumber(String phoneNumber) {
        response = requestSpec.when()
                .queryParam("phone_number", phoneNumber)
                .get();
    }

    @Then("I get a successful response")
    public void iGetASuccessfulResponse() {
        response.then()
                .statusCode(200);
    }

}
