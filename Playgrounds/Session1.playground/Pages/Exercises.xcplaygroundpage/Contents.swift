//: [Previous](@previous)

/*:

### Homework Exercises

Open up the project **IntroWorkshop.xcodeproj** and implement the following. 
It is recommended that you follow a TDD approach.

1. Create a new Swift file called `JSON.swift` and add a `typealias` to represent JSON types

```
typealias JSON = [String: Any]
```

2. Create an `Account` model object that represents one of the account objects from `GetAccounts.json`. Remember to also create a designated intializer which takes in every property to create the object.
3. Implement a readonly property `maskedAccountNumber` that returns a `String` of the account number masked. E.g. "1234 5678 9012 3456" becomes "XXXX XXXX XXXX 3456".
4. Create an initializer that takes the JSON dictionary and parses it into a single `Account` model object. Notice it is a failable initializer, which means it returns nil if it doesn't work.
 
```
init?(json: JSON) {
}
 
```

5. Write a type method `Account.accountList(json:)` that parses the JSON dictionary and returns the array of `[Account]`.
```
static func accountList(json: JSON) -> [Account] {
}

```

**Note:** 

For this exercise, there is no need to read the JSON file. In your unit tests, just supply your test data directly as a dictionary. For example:

```
let json: JSON = [
    "accountName": "Complete Access",
    "accountNumber": "1234 2345 5678 9123",
    "availableFunds": 12.34,
    "accountBalance": 34.56
]
```

 
**Tip:**

Unit tests are compiled into a different bundle to the app itself.
In order to give your unit tests access to the `internal` objects defined in the app (e.g. the `Account` object), you will need to expose it:

```
@testable import IntroWorkshop
```


*/

//: [Next](@next)

