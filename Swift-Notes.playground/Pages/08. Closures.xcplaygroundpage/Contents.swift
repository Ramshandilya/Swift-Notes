//: # Swift Foundation
//: ----
//: ## Closures

//: Closures are self-contained blocks of functionality that can be passed around and used in your code.

//: Closures can capture and store references to any constants and variables from the context in which they are defined. This is known as *closing* over those constants and variables, hence the name ***closures***. Swift handles all of the memory management of capturing for you.

/*:
Closures can take 3 forms:
* Global functions are closures that have a name and do not capture any values.
* Nested functions are closures that have a name and can capture values from their enclosing function.
* Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
*/

//: So Global and Nested Functions are actually special cases of closures.

//Closure syntax

let incrementClosure = { (a: Int) -> Int in
    return a + 1
}

/*:
Anatomy of a closure
* Entire closure is wrapped in a pair of curly braces.
* The parameters are enclosed in a parantheses
* The parameter is separated from return by the `->` symbol.
* The body of the closure starts after the `in` keyword.
*/

//: Closure expression syntax can use constant parameters, variable parameters, and inout parameters. Default values cannot be provided. Variadic parameters can be used if you name the variadic parameter and place it last in the parameter list. Tuples can also be used as parameter types and return types.

var names = ["Jon Snow", "Tyrion Lannister", "Daenerys Targaryen", "Arya Stark"];

let orderedNames = names.sort ({ (a: String, b: String) -> Bool in
    return a < b
//    return a.characters.count < b.characters.count
    
})

print(orderedNames)

//: Swift's standard library provides a function called `sort`. `sort` is performed on each pair of items, sorts them based on the closure content and returns a new array with the sorted values.

//: ### Inferring type from context
//: The type of the parameters of `sort` function and its return value can be inferred from the type of sort function.
//: 😏 It's obvious that it will be of the same type of the elements in the array.

let condensedOrderedNames = names.sort ({ a, b in
    return a < b
})

//: ### Implicit returns from Single-Expression closures
//: 😏 It's very obvious that it's gonna return Bool. Duh. Let's remove the return keyword.
let lightOrderedNames = names.sort({ a, b in a < b })

//: ### Shorthand argument names
//: 😏 We can refer closures arguments by $0, $1, $2...and so on. So let's get rid of the argument list. Yes the `in` keyword also.

let superLightNames = names.sort( { $0 < $1 } )

//: ### Operator Functions
//: The string-specific implementation of the greater-than operator is a function that takes 2 strings and returns a Bool. This is exactly the function type of `sort`
//: 😎 So let's remove the shorthand arguments

let ultraLightNames = names.sort(<)

//More on Operator Functions later.

//: ### Trailing Closures
//: When you pass a closure as the last argument of a function, we can use trailing closure.

//Write the closure after the function paranthesis is closed.
let trailingClosureNames = names.sort(){ $0 < $1 }

//If the closure is the only argument, we can get rid of the paranthesis totally.
let noParanthesisNames = names.sort{ $0 < $1 }


//: Recap of how we trimmed it down
names.sort ({ (a: String, b: String) -> Bool in return a < b })
names.sort ({ a, b in return a < b }) //Infer Type
names.sort({ a, b in a < b }) //Implicit returns for single expression closures.
names.sort( { $0 < $1 } ) //Shorthand argument names
names.sort(){ $0 < $1 } //Trailing Closures - Last argument of a function
names.sort{ $0 < $1 } //If it's the only argument of a function.

let numbersArray = [1, 2, 3, 4, 5, 6, 7]

let doubledNumbers = numbersArray.map({(a: Int) -> Int in return a * 2})
doubledNumbers

//: ## Capturing Values

func exclamator(var quote: String) -> () -> String {
    
    print(quote)
    
    func exclaimClosure() -> String {
        quote += "!"
        return quote
    }
    
    print(quote)
    
    return exclaimClosure
}

let ygritteWords = exclamator("You know nothing, Jon Snow")

ygritteWords()

//: Closure are reference types. The `exclaimClosure` doesn't have any parameters, yet it refers to `quote` in its body. It does by ***capturing*** the existing values of `quote` from its surrounding function and using it within its body. The closure captures a reference of the `quote` and not just its copy of the initial value.

ygritteWords()
ygritteWords()
ygritteWords() //Notice the growing exclamation marks.

let starkWords = exclamator("Winter is Coming")
starkWords()
starkWords()

//ANOTHER EXAMPLE

func makeIncrementer(amount: Int) -> Void -> Int {
    var currentTotal = 0
    
    func incrementer() -> Int {
        print(currentTotal)
        currentTotal += amount
        return currentTotal
    }
    
    return incrementer
}

let incrementByFive = makeIncrementer(5)

incrementByFive()
incrementByFive()
incrementByFive()
incrementByFive()

let incrementByEight = makeIncrementer(8)
incrementByEight()
incrementByEight()
incrementByEight()

//: ### Closures are reference Types
//: Capturing values occur because Functions and Closures are reference types. So when you assign a function or a closure to a variable/constant, you are setting it to a reference of the function or closure. 

//: So if you assign a new closureto two different constants/variables, both of these will refer to the same closure.

let ygritteAgain = ygritteWords
ygritteAgain()

let anotherIncrementByFive = incrementByFive
anotherIncrementByFive()


//: ----
//: [Next](@next)
