# Test Back Senior by Eduardo Riol
A set of executable Gherkin scenarios written in Java to test the Search Contacts API.
## Requirements
- [Java](https://jdk.java.net/) 17+
- [Maven](https://maven.apache.org/download.cgi) 3.6.3+
- Have a valid Aircall API account.
### Test plan & tools selection
The test plan has been defined in the format of a set of scenarios following the __Gherkin__ syntax (Given / When / Then). It can be found in the following file:
`src/test/resources/com/github/test/back/senior/searchContact.feature`

The reasoning for this choice is that, using __Cucumber__, we can directly automate the test plan as a set of executable scenarios, emulating a BDD (Behaviour Driven Development) approach.

Also, __Java__ is one of the programming languages which I have more experience with, and using the library __REST Assured__, we can leverage a nice fluent API to test backend services.
## Run the scenarios
As usual, first step is cloning the repo :)
```
git clone https://github.com/eduriol/test-back-senior.git
cd test-back-senior
```
### Local execution
For security reasons, the API id and API token are not stored anywhere. You need to set them beforehand as environment variables in order to successfully execute the scenarios:
```
export API_ID=<API_ID>
export API_TOKEN=<API_TOKEN>
```
Once this is done you can run the scenarios by simply running the following command:
```
maven test
```
### Reports
Pending...
## Manually test API
To perform a basic manual GET petition to Contact API, you can execute the following cURL command:
```
curl --request GET '{{host}}/v1/contacts/search?order=asc&order_by=created_at&phone_number={{phone_number}}' \
--header 'Authorization: Basic {{token}}'
```
Or import into Postman the collection contained in the __Contact_API.postman_collection.json__ file. It contains a basic call to _Search contact_ endpoint.
Either when using the cURL command or the Postman collection, remember to update the values enclosed within {{}}.

## Issues found
During the completion of the tests, the following findings were made:
- In [the documentation](https://developer.aircall.io/api-references/#basic-auth-aircall-customers), it says _"click on Add a new API key and get your api_token and api_token"_. It should probably be __api_id__ and __api_token__.

A discussion to confirm whether these findings are real issues is recommended.
## Contribution
If you'd like to contribute to the project, please send a [Pull Request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests) or contact eduriol [at] gmail.com.
