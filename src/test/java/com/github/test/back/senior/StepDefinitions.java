package com.github.test.back.senior;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import static io.restassured.RestAssured.given;
import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchemaInClasspath;
import static org.hamcrest.Matchers.equalTo;

public class StepDefinitions {

    private RequestSpecification requestSpec;
    private Response response;

    @Given("I have an account with access to the Contacts API")
    public void iHaveAnAccountWithAccessToTheContactsAPI() throws IOException {
        TestConfigurator configurator = new TestConfigurator();
        Map<String, String> configuration = configurator.getTestConfiguration();
        requestSpec = given()
                .baseUri(configuration.get("base_uri"))
                .basePath(configuration.get("base_path"))
                .header("Authorization", "Basic " + configuration.get("auth_token"));
    }

    @When("I search for the contact with the following parameters:")
    public void iSearchForTheContactWithTheFollowingParameters(Map<String, String> parameters) {
        response = requestSpec.when()
                .queryParams(parameters)
                .get();
    }

    @Then("the response has a correct format")
    public void theResponseHasACorrectFormat() {
        response.then()
                .assertThat()
                .body(matchesJsonSchemaInClasspath("expected-responses-schemas/successfulResponseSchema.json"));
    }

    @Then("the field {string} is empty")
    public void theFieldIsEmpty(String field) {
        response.then()
                .assertThat()
                .body(field, equalTo(Collections.emptyList()));
    }

    @Given("I have an account with bad token")
    public void iHaveAnAccountWithBadToken() throws IOException {
        TestConfigurator configurator = new TestConfigurator();
        Map<String, String> configuration = configurator.getTestConfiguration();
        requestSpec = given()
                .baseUri(configuration.get("base_uri"))
                .basePath(configuration.get("base_path"))
                .header("Authorization", "Basic a_bad_token");
    }

    @Then("I can proceed to next page")
    public void iCanProceedToNextPage() {
        String nextPageLink = response.path("meta.next_page_link");
        requestSpec.get(nextPageLink)
                .then()
                .assertThat()
                .statusCode(200)
                .and()
                .assertThat()
                .body("meta.current_page", equalTo(2));
    }

    @Then("I get a(n) {string} response")
    public void iGetAResponse(String responseType) {
        Map<String, Integer> statuses = new HashMap<>();
        statuses.put("Successful", 200);
        statuses.put("Bad request", 400);
        statuses.put("Unauthorized", 401);
        response.then()
                .assertThat()
                .statusCode(statuses.get(responseType));
    }
}
