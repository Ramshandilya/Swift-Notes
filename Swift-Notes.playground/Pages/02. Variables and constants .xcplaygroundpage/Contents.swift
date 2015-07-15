//: # Swift Foundation
//: ----
//: ## Variables and Constants

//: Declare variables with `var` keyword and constants with `let`

let numberOfRooms = 3
var numberOfDogs = 1

//numberOfRooms += 1 // ❌ ERROR!
numberOfDogs += 1

//: ## 😋
//: Declaring it as constants allows the compiler to perform some optimizations. So always start with `let`. If you need to change it's value, declare it as a `var`.


//: #### Inferred Typing & Explicit Typing

let someVariable = 10

//: The compiler knows 10 is an `Int`, so it set the type of `someVariable` to an Int for you automatically.

let boringWelcomeText = "Hello World!" //This is of String Type

//: Type Annotation - The type can also be set explicitly by
let coolText: String = "Astala Vista, Baby!"

//: ## 😋
//: It is good practice to let the compiler infer types wherever possible.

//: #### Naming variables and constants
//Swift is fully unicode compliant.
let direWolf = "🐺"
let 🐷 = "Pig"
let π = 3.14159

//: 🚫 - Constant and variable names cannot contain whitespace characters, mathematical symbols, arrows, private-use (or invalid) Unicode code points, or line- and box-drawing characters.

//: #### Printing contants and variables

print(boringWelcomeText)
print(coolText)

print("The value of Pi is \(π)")

//: #### Comments

//This is a single line comment

/* This is a multi-line comment.
Insert long code description 😐 */

//: #### Semicolons

let dragon = "🐲" //No semicolons required

//: Semicolons are required, however, if you want to write multiple separate statements on a single line

let babyDragon = "🐣"; print("This is how my baby dragon looks like - \(babyDragon)")

//: ---
//: [Next](@next)

