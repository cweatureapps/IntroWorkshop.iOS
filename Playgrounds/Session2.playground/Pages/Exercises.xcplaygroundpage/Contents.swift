//: [Previous](@previous)

/*:

## Exercises

### Exercise 1

Implement a raw value String Enum called `ServiceURLs` which defines endpoints, and has the URL of the endpoint as the raw value.

The case of `getAccounts` should map to:

https://raw.githubusercontent.com/cweatureapps/IntroWorkshop.iOS/master/MockResponses/GetAccounts.json


### Exercise 2

Two concrete implementations for `ServiceHelper` protocol have already been provided.
These are `NetworkServiceHelper` and `StubServiceHelper`.
Change `AccountService` initializer to use constructor DI, so that a unit test can swap out to the stub implementation.
Provide a default value for this parameter. You can get a default implementation by calling the provided `ServiceHelperFactory.makeServiceHelper()`


### Exercise 3

The `AccountService` class has a method `getAccounts` which makes an async call to the service, and calls the completion when it is done.
If successful, it passes along the accounts; If it fails, it passes along the error.
(i.e. the parameter is a `Result` type).

Finish the definition of this method.

 

### Exercise 4

Implement the `getAccounts` method for the `AccountService` class, starting with TDD using an async unit test.


*/
