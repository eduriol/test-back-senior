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