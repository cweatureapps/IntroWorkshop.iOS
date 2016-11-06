//: [Previous](@previous)

import Foundation

/*:

### Homework Exercises

Open up the project **IntroWorkshop.xcodeproj** and implement the following. 
It is recommended that you follow a TDD approach.

1. Create a new Swift file called `JSON.swift` and add a `typealias` to represent JSON types

```
typealias JSON = [String: Any]
```

2. Create an `Account` model object that represents one of the account objects from `GetAccounts.json`.
3. Implement a readonly property `maskedAccountNumber` that returns a `String` of the account number masked. E.g. "1234 5678 9012 3456" becomes "XXXX XXXX XXXX 3456". Follow TDD and write the unit test for this first.
4. Make the `Account` conform to `Codable` so that you can parse the JSON.
5. Write a unit test that you can run to assert that the values can be parsed correctly. For example:

```
let json: JSON = [
    "accountName": "Complete Access",
    "accountNumber": "1234 2345 5678 9123",
    "availableFunds": 12.34,
    "accountBalance": 34.56
]
let data = try JSONSerialization.data(withJSONObject: json, options: [])
let account = try JSONDecoder().decode(Account.self, from: data)

// TODO: assert that the account properties are correct

```

 
**Tip:**

Unit tests are compiled into a different bundle to the app itself.
In order to give your unit tests access to the `internal` objects defined in the app (e.g. the `Account` object), you will need to expose it:

```
@testable import IntroWorkshop
```


*/

//: [Next](@next)

