//: # Swift Foundation
//: ----

//: ## Enumerations

//: An enumeration defines a common type for a group of related values. Enumerations in Swift are first-class types in their own right.

enum Dragon {
    case Unknown
    case Drogon
    case Rhaegal
    case Viserion
}

var myDragon = Dragon.Drogon

//: Enums in Swift have more features compared to C and Objective-C.
//: Enums can have computed properties, instance methods, initializers, can be extended and can conform to protocols.

myDragon = .Rhaegal

//Matching enums with ***switch*** statement

switch myDragon {
case .Drogon :
    print("Drogon is black with red")
case .Rhaegal:
    print("Rhaegal is green with bronze")
case .Viserion:
    print("Viserion is cream with gold")
default:
    print("Unknown Dragon")
}

//: ### Associated Values



//: ---
//: [Next](@next)