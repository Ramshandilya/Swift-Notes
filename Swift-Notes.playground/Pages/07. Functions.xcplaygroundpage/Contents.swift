//: # Swift Foundation
//: ----
//: ## Functions

//: Functions are self-contained chunks of code that can perform a specific task.

//: Every Swift function has a specific ***function type***, made up of the parameter types and the return type of the function. You can use this like any other type in Swift, which makes it easy to pass functions as parameters or return functions from functions. Nested functions are also possible.

func simpleGreeting(param1: String, param2: String) -> String{
    return param1 + " " + param2 + "!"
}

/*: 
Anatomy of a function in Swift
* `func` keyword denotes that it is a function
* `simpleGreeting` is the name of the function
* The function takes in 2 parameters. One parameter `param1` of `String` type & another parameter `param2` also of `String` type. Separated by commas.
* `-> String` is the return type. The function returns a `String`
*/

//: ### Calling a function

simpleGreeting("Valar", param2: "Morghulis")

//Function with no parameters
func fancyGreeting() -> String{
    return "Valar Dohaeris"
}

//Function with no return type

func coolGreeting(){
    print("Hey!...How you doin?")
}

//Since the above function doesn't return a value, the function doesn't include a `->` arrow or a return tyoe

//: ## 📖
//: The function `coolGreeting()` actually does return a value. It returns a special value of type `Void`. `Void` is a simply an empty tuple, which can be written as `()`.

//: ### Function with multiple return types
//Yes.. we have tuples.

func weatherAtWinterfell() -> (min: Int, max: Int){
    return (-40, -15)
}

let weather = weatherAtWinterfell()
weather.min

//: ### Function parameter names
//: Function parameters have both an ***external parameter name*** and a ***local parameter name***. An external parameter name is used to label arguments passed to a function call. A local parameter name is used in the implementation of the function.

simpleGreeting("Valar", param2: "Morghulis")

//: By default, the function call omits the first parameter's external name and the subsequent parameters use thier local names as external names.

//Specifying external names

func niceQuote(firstWord param1: String, secondWord param2: String) -> String {
    return param1 + " is " + param2 + "!"
}

niceQuote(firstWord: "Winter", secondWord: "Coming")

//: ## 📖
//: All parameters must have unique local names, but may share external parameter in common.

//Omitting external parameter name

func coolQuote(param1: String, _ param2: String) -> String{
    return param1 + " " + param2
}

coolQuote("North", "Remembers")


//: ### Default Parameter values

func yetAnotherGreeting(param1: String = "Hey!") -> String {
    return param1
}

yetAnotherGreeting()
yetAnotherGreeting("Howdy!")

//: ## 😋
//: Place parameters with default values at the end of a function’s parameter list. This ensures that all calls to the function use the same order for their nondefault arguments, and makes it clear that the same function is being called in each case.

//: ### Variadic Parameters
//: A variadic parameter accepts zero or more values of a specified type.

import Foundation

func nextVictim(names : String...) -> String {
    let count = names.count
    if count > 0 {
        let randomIndex = random() % count
        return names[randomIndex]
    } else {
        return "Lucky!"
    }
}

nextVictim("Daenerys", "Arya", "Tyrion", "Jon", "Ramsey")
nextVictim()

//A function may have at most one variadic parameter. Place it after default parameters.

//: ### Variable parameters
//: Function parameters are constants by default. Trying to change the value of a function parameter from within the body of that function results in a compile-time error. This means that you can’t change the value of a parameter by mistake.

//: Variable parameters are declared by prefixing parameter name with `var`.

func swapNames(var param1: String, var param2: String) {
    let temp = param1
    param1 = param2
    param2 = temp
    
    print(param1)
    print(param2)
}

var myName = "Goku"
var hisName = "Vegata"

swapNames(myName, param2: hisName)

print(myName)
print(hisName)

//: ## 📖
//: The changes you make to a variable parameter do not persist beyond the end of each call to the function, and are not visible outside the function’s body. The variable parameter only exists for the lifetime of that function call.

//: ### In-Out Parameters
//: If you want to persist the changes to the variables passed, define that parameter as `inout` instead.

func swapNamesForReal(inout param1: String, inout param2: String) {
    let temp = param1
    param1 = param2
    param2 = temp
    
    print(param1)
    print(param2)
}

swapNamesForReal(&myName, param2: &hisName)

print(myName)
print(hisName)

/*:
## 📖
* In-out parameters cannot have default values
* Variadic parameters cannot be inout
* If marked as `inout`, the parameter cannot also be var or let
* In-out parameters are not the same thing as returning a value from a function. It is an alternative way for a function to have an effect outside of the scope of its function body.
*/

//: ## Function Types
//: Every function has a specific ***function type***, made up of the parameter types and the return type of the function.

/*: 
Type of `swapNames` function is `(String, String) -> Void`

Type of `weatherAtWinterfell` is `() -> (Int, Int)`
*/

let greeting = fancyGreeting
print(greeting())

let quote = coolQuote
print(quote("I <3 ", "swift"))

//: ### Function Types as parameter types

func addNumbers(a: Int, _ b: Int) -> Int {
    return a + b
}

func subtractNumbers(a: Int, _ b: Int) -> Int {
    return a - b
}

func printMathOperation(mathOperation: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathOperation(a,b))")
}

printMathOperation(addNumbers, 10, 13)
printMathOperation(subtractNumbers, 24, 15)

//: ### Function as Return Types

enum Operator {
    case Add
    case Subtract
}

func chooseOperationForOperator(op: Operator) -> (Int, Int) -> Int {
    switch op {
    case Operator.Add:
        return addNumbers
    case Operator.Subtract:
        return subtractNumbers
    }
}

let someOperation = chooseOperationForOperator(.Add)
print(someOperation(3, 5))

//: ### Nested functions 

func chooseOperation(op: Operator) -> (Int, Int) -> Int {
    
    func add(a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    func subtract(a: Int, _ b: Int) -> Int {
        return a - b
    }
    
    switch op {
    case Operator.Add:
        return add
    case Operator.Subtract:
        return subtract
    }
}

let anotherOperation = chooseOperation(.Subtract)
print(anotherOperation(8, 6))

//: ----
//: [Next](@next)
