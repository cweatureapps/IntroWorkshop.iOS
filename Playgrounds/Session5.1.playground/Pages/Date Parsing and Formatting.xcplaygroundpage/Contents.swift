import Foundation

/*:
# Date Parsing and Formatting

The `DateFormatter` can be used for parsing dates from string, and for formatting dates into strings.
*/

let formatter = DateFormatter()
formatter.dateFormat = "dd/MM/yyyy"
let d = formatter.date(from: "01/12/2016")

/*:
Note that the `DateFormatter` is expensive to create.
(For example, it would be bad practice to create a new one of these objects whenever you set up your table cell while the user is scrolling up and down on a table.)
The general approach is to create a static instance and use that:
*/
class SomeClass {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    func doSomething() -> String {
        return SomeClass.dateFormatter.string(from: Date())
    }
}
SomeClass().doSomething()


/*:
 The `Calendar` object has APIs to perform calendar queries or 
 calendar based calculations.
 */

// Find out the calendar date components (e.g the day, month, year, hour, minute, second, etc)
let components = Calendar.current.dateComponents([.day, .month, .year], from: d!)
components.day
components.month
components.year



// Work out how many days between 2 dates
Calendar.current.dateComponents([.day], from: d!, to: Date()).day

//: [Next](@next)
