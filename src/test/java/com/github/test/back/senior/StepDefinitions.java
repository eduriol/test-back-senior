package com.github.test.back.senior;

import io.cucumber.java.en.Given;

public class StepDefinitions {

    @Given("I have an account with access to the Contacts API")
    public void iHaveAnAccountWithAccessToTheContactsAPI() {
        System.out.println("Hello, cucumber!");
    }
}
