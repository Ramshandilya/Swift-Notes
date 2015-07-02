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

import Foundation

var names = ["Jon Snow", "Tyrion Lannister", "Daenerys Targaryen", "Arya Stark"];

let abbreviatedNames = names.map { (name: String) -> String in
    let words = name.componentsSeparatedByString(" ")
    
    var abbreviation: String = ""
    
    for word in words {
        abbreviation += String(word.characters.first!)
    }
    
    return abbreviation
}

//: Swift's standard library provides a function called `map`. `map` is performed on each item, transforms each item based on the closure content and returns a new array with the transformed values.



//: ----
//: [Next](@next)
