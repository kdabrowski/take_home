# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Database creation
```
rake db:setup
```
* How to run the test suite
```
rspec
```

* About the assignment
I've created multiple endpoints for authorisation and user creation
To create a new user hit the:

`/api/v1/users/create`

with the params:

```
user_name
password
```

This will create a user and will generate a JWT token needed to log ing. 
The JWT token neads to be given in the 'Authorisation' header to be able to hit event specific endpoints.


`/api/v1/events/create` <- for creating a new event
`/api/v1/events/book` <- for booking an existing event
`/api/v1/events/organised` <- for fetching events that the current user has organised
`/api/v1/events/participating` <- for fetching the events the current user is participating in
`/api/v1/events/participants` <- for feching participants for an event. There is an event param needed 


