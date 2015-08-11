//: # Swift Foundation
//: ----
//: ## Generics
//: *Generic code* enables you to write flexible, reusable functions and types that can work with any type.

//: ### The Problem
/*
The below example is commented as it doesn't work.
http://stackoverflow.com/questions/31697093/cannot-pass-any-array-type-to-a-function-which-takes-any-as-parameter

let names = ["Joffrey", "Cersei", "Mountain", "Hound"]
let ranks = [1, 2, 3, 4, 5]
let weights = [141.2, 166.0, 173.8, 220.3]

//Let's create funcitons to print each element for the arrays

func printNames(items: [String]){
    for item in items {
        print(item)
    }
}

func printRanks(items: [Int]){
    for item in items {
        print(item)
    }
}

func printWeights(items: [Double]){
    for item in items {
        print(item)
    }
}

//: Clearly the there is code duplication. The body of the three functions are identical. We can get away by  replacing the type with `Any`

func printItems(items: [Any]){
    for item in items {
        print(item)
    }
}

printItems(names)
printItems(ranks)

*/

func swapIntegers(inout a: Int, inout _ b: Int){
    let temp = a
    a = b
    b = temp
}

var foo = 10
var bar = 15

swapIntegers(&foo, &bar)
foo
bar

// Let's create more such functions to swap Doubles, Strings etc.

func swapStrings(inout a: String, inout _ b: String){
    let temp = a
    a = b
    b = temp
}

func swapDoubles(inout a: Double, inout _ b: Double){
    let temp = a
    a = b
    b = temp
}

//: Clearly the there is code duplication. The body of the three functions are identical. The only difference is the type of the parameters.

func swapTwoItems(inout a: Any, inout _ b: Any) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//: Using `Any` might seem to work but it'll fail when the parameters are of different types.

var someInt = 3
var someString = "Foo"

//swapTwoItems(&someInt, b: &someString)

//: By using `Any` we've lost type safety.

//: ### Enter Generics.
//: Generic funcitons can work with any type.

func swapTwoValues<T>(inout a: T, inout _ b: T) {
    let temp = a
    a = b
    b = temp
}

// Let's test.

var string1 = "Valar"
var string2 = "Morghulis"

swapTwoValues(&string1, &string2)

string1
string2

/*---------------------------------------*/

var integer1 = 123
var integer2 = 456

swapTwoValues(&integer1, &integer2)

integer1
integer2

/*---------------------------------------*/

// And this is not possible.

//swapTwoValues(&string1, &integer1)

/*---------------------------------------*/

//: ## 😋👍

//: Instead of an actual type (`Int`, `String`, `Double`), we are using a *placeholder* type (called T, in this case). It says the type of `a` and `b` have to be of type `T`, whatever `T` represents. Also, we've put the `T` in angle brackets (`<T>`) after the function name so that swift doesn't look for an actual type called `T`.

//: ### Type Parameters
//: The placeholder type `T` is a example of a ***type parameter***.

//: Generics allow us to write flexible functions that accept any type as a parameter. In fact, we can specify more than one generic type when defining functions.

func someFunction<T, U>(a: T, _ b: U) -> (T, U) {
    return (a, b)
}

let stringIntTuple = someFunction("One", 1)
let intDoubleTuple = someFunction(2, 3.14)


//: Swift allows us to use any valid identfier as the type parameter name. But it is conventional to use single-character name `T`.

//: ### Generic Types
//: Swift also lets us define ***generic types***. Generic types are custom classes, enumerations and structs that work with any type, similar to how Swift collections like Array and Dictionary do.

struct GenericStack<T> {
    var items = [T]()
    
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() {
        items.removeLast()
    }
}

var pizzaStack = GenericStack<String>()
pizzaStack.push("Regular")
pizzaStack.push("Cheeseburst")
pizzaStack.push("Double Cheeseburst")
pizzaStack.push("Large")
pizzaStack.pop()

pizzaStack.items

/*:
    struct Dictionary<Key, Value> { //implementation }
*/


//: ### Extending Generic Type

extension GenericStack {
    var top: T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

let top = pizzaStack.top //Optional String

//: ### Type Contraints

//Syntax

/*:
    func someFuntion<T: SomeClass, U: SomeProtocol>(a: T, b: U) {
        //implementation
    }
*/

func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

//: The above function will take any type provided the type conforms to `Equatable` protocol. This is because the line `if value == valueToFind` may not work for all swift types.

//: ### Associated Types
//: Associated types gives a placeholder name to a type that is used as part of protocol. The actual type to use for that associated type is not specified until the protocol is adopted.

protocol Printer {
    
    typealias ItemType
    
    func returnValue() -> ItemType
}

struct IntStruct: Printer {
    var value: Int
    
    func returnValue() -> Int {
        return value
    }
}

struct StringStruct: Printer {
    var value: String
    
    func returnValue() -> String {
        return value
    }
}

struct GenericStruct<T>: Printer {
    var value: T
    
    func returnValue() -> T {
        return value
    }
}

//: ### Where Clause
//: Where clause can be used to define requirements for associated types.

func someFunction<P1: Printer, P2: Printer where P1.ItemType == P2.ItemType, P1.ItemType: Equatable> (firstPrinter: P1, _ secondPrinter: P2) {
    firstPrinter.returnValue()
    secondPrinter.returnValue()
}


/*:
* P1 must conform to `Printer` protocol.
* P2 must conform to `Printer` protocol.
* ItemType of P1 must be saem as the ItemType for P2
* The ItemType for P1 should be same as the ItemType for P2.
* The ItemType for P1 must conform to Equatable protocol.
*/


/*:
These requirements mean:
* `firstPrinter` is a printer of type P1.
* `secondPrinter` is a printer of type P2.
* `firstPrinter` and `secondPrinter` contain the same type of items.
* The items in `firstPrinter` can be checked with the equal operator (`==`).
*/


let intPrinter = IntStruct(value: 10)
let genericIntPrinter = GenericStruct<Int>(value: 12)

someFunction(intPrinter, genericIntPrinter) // Works perfectly

let genericStringPrinter = GenericStruct<String>(value: "Hi")
someFunction(genericIntPrinter, genericStringPrinter) //Doesn't work

let stringPrinter = StringStruct(value: "World")
someFunction(stringPrinter, genericStringPrinter) //Works perfectly

//: ----
//: [Next](@next)
