//: [Previous](@previous)

import Foundation

/*:
# Generics

* generic functions
* generic types
* associated types

*/

//: ## Generic functions

var universalCollection: [Any] = []

// without generics

func addToCollection(_ i: Int) {
    universalCollection.append(i)
}
func addToCollection(_ s: String) {
    universalCollection.append(s)
}

//// generics version, including constraint
//func addToCollection<T: Equatable & Comparable>(_ elem: T) {
//    universalCollection.append(elem)
//}

////try this one... won't be able to add String
//func addToCollection<T: Equatable & Comparable & SignedInteger>(_ elem: T) {
//    universalCollection.append(elem)
//}

addToCollection(3)
addToCollection("asdf")
universalCollection

// notice when you use generic functions, the types are inferred, dont need to specify them


//: ## Generic Types

struct Stack<T> {
    var items = [T]()
    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() -> T? {
        guard count > 0 else { return nil }
        return items.removeLast()
    }
    var count: Int {
        return items.count
    }
}

/*:
### Homework Exercise

Implement your own generic collection `LinkedListStack` for a linked list stack.

**Hint**

Use reference semantics.

Node
- value
- previousNode
- nextNode

LinkedListStack
- firstNode
- lastNode
- count
- push(item)
- pop() -> item

*/


//--------------------

//: ### Solution

class Node<T> {
    let value: T
    var prevNode: Node?
    var nextNode: Node?

    init(value: T) {
        self.value = value
    }
}

class LinkedListStack<T> {

    var firstNode: Node<T>?
    var lastNode: Node<T>?
    var count = 0

    init() {
    }

    func push(_ value: T) {
        let newNode = Node<T>(value: value)
        if let lastNode = lastNode {
            lastNode.nextNode = newNode
            newNode.prevNode = lastNode
            self.lastNode = newNode
        } else {
            // no last node, must be empty
            firstNode = newNode
            lastNode = newNode
        }
        count += 1
    }

    func pop() -> T? {
        guard let firstNode = firstNode, let lastNode = lastNode else { return nil }
        count -= 1
        // one node
        if firstNode === lastNode {
            let result = lastNode.value
            self.firstNode = nil
            self.lastNode = nil
            return result
        } else {
            let result = lastNode.value
            self.lastNode = lastNode.prevNode
            return result
        }
    }
}
//--------------------


// expected output

// var list = Stack<Int>()
var list = LinkedListStack<Int>()
list.count

list.push(100)
list.push(200)
list.push(300)
list.count  // 3

list.pop()  // 300
list.pop()  // 200
list.count  // 1

list.push(1000)
list.pop()  // 1000
list.pop()  // 100
list.count  // 0
list.pop()  // nil
list.count  // 0
list.pop()  // nil
list.count  // 0

list.push(2000)
list.pop()  // 2000
list.count  // 0


//:## (Advanced)

/*:
## Associated Types

Works as a placeholder for a type, and allows the implementation to fill in the details
*/

//: Consider the following...

protocol Food {}
struct Grass: Food {}
struct Algae: Food {}


//---
protocol Animal {
    func eat(food: Food)
}
struct Cow: Animal {
    func eat(food: Food){}
}
struct Horse: Animal {
    func eat(food: Food){}
}
struct Fish: Animal {
    func eat(food: Food){}
}

// this is bad because:
let h = Horse()
h.eat(food: Algae())
//---




//: Using associated type:

//protocol Animal {
//    associatedtype FoodType: Food
//    func eat(food: FoodType)
//}
//
//struct Cow: Animal {
//    func eat(food: Grass){}
//}
//struct Horse: Animal {
//    func eat(food: Grass){}
//}
//struct Fish: Animal {
//    func eat(food: Algae){}
//}
//let h = Horse()
//h.eat(food: Grass())




//: Can be used as a generic constraint

//func feedAnimals<T: Animal>(animals: [T], food: T.FoodType) {
//    for a in animals {
//        a.eat(food: food)
//    }
//}
//let cows = [Cow(), Cow()]
//feedAnimals(animals: cows, food: Grass())


/*:
 Further reading:
 
 [Swift Programming Language - Generics](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179)
 */

//: [Next](@next)
