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

//: Enums in Swift have more features compared to C and Objective-C (they are not typealias for Intds etc.)
//: Enums can have computed properties, instance methods, initializers, can be extended and can conform to protocols.

myDragon = .Rhaegal

//Matching enums with `switch` statement

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

enum Location {
    case Coordinates (Double, Double)
    case Name (String)
}
//This means that the types of associated values of constants/variables of Location are (Double, Double) or (String)

var officeHQ = Location.Coordinates(223.4, 345.7)

officeHQ = Location.Name("Chennai")
//At this point, the original Location.Coordinate and its values are replaced by Location.Name and its String value. 

switch officeHQ {
case let .Coordinates(lat, long):
    print("Location is at lat:\(lat), long:\(long)")
case let .Name(someName):
    print("Location is at \(someName)")
}

//: ### Methods

enum Place {
    case Unknown
    case Westeros
    case Essos
    
    init(){
        self = .Unknown
    }
}

var nicePlace = Place() //.Unknown

//: ### Value Types
//: Enumerations are value types, which means than an enum is passed by value and not by reference (like Classes).

let somePlace = nicePlace

nicePlace = .Westeros

print(nicePlace)
print(somePlace)

//: ## 📖
//: When nicePlace is assigned to somePlace, Swift creates a copy of nicePlace and assigns that to somePlace. In other words, nicePlace and somePlace refer to two different instances (not shared).


//: ### Raw Values
//: As an alternative to associated values, enumeration members can come prepopulated with default values (called raw values), which are all of the same type.

enum Animal : String {
    case Dragon = "🐉"
    case Wolf = "🐺"
    case Dog = "🐶"
}

//: ## 📖
//: Raw values are not the same as associated values. Raw values are set to prepopulated values when you first define the enumeration in your code. The raw value for a particular enumeration member is always the same. Associated values are set when you create a new constant or variable based on one of the enumeration’s members, and can be different each time you do so.


//: ## 📖
//: Each raw value must be unique within its enumeration declaration.

//Auto Increment
//When integers are used for raw values, they auto-increment if no value is specified for some of the enumeration members.

enum Month : Int {
    case Jan = 1
    case Feb
    case Mar
    case Apr
    case May
}

let someMonth = Month.Apr.rawValue

//Initializing from Raw Value

let anotherMonth = Month(rawValue: 5)

//: ## 📖
//: The raw value initializer is a failable initializer, because not every raw value will return an enumeration member.

//Therefore the raw value initializer will return nil for raw values not present in the enum.
//So the type of anotherMonth will be....Month? and not Month

//Knowing when to use enums and when to use other data types (such as classes or structs) can be a bit difficult. They are most useful when you have a closed set of possible values.

//For eg. an optional is a enum behind the scenes.

enum OptionalType<T> {
    case Nil
    case Some(T)
}

//Enums in Swift are incredibly powerful compared to, for example, enums in C. One of the most important aspects of enumerations is that they are a first class types in Swift and they are Value Types.

//: ---
//: [Next](@next)
