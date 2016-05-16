//: # Swift Foundation
//: ----
//: ## Basic Types

//Int
let numberOfDragons = 3 //This is an Int
let numberOfKingdoms: Int = 7

//Floats and Doubles
let weightOfHodor = 125.3 //Default decimal type is Double
let weightOfSam: Float = 107.6 //Float
let heightOfMountain: Double = 208 //Double

//Number Formatting
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

//Bools
let shouldITrustHim = false
let amIAwesome: Bool = true


//Typealias - Define an alternative name for existing type
typealias Abc = UInt64

let foo: Abc = 0

//: ### Strings

let emptyString = ""
let anotherString = String()
emptyString == anotherString

let greeting = "Valar Morghulis!"
let anotherGreeting: String = "Valar Dohaeris!"
greeting == anotherGreeting

let combinedGreeting = greeting + " and " + anotherGreeting

combinedGreeting.characters.count

//: ### Tuples
//: Tuples group multiple values into a single compound value. The values within a tuple can be of any type and do not have to be of the same type as each other.

let jaime = (38, "Lannister") //This is of type (Int, String)

//Decompose Tuple
let (age, family) = jaime
print("Jaime is \(age) and a \(family)")

let (_, justFamily) = jaime
print("Jaime is a \(justFamily)")

print("Jaime is \(jaime.0) and a \(jaime.1)")

//Name individual elements
let tyrion = (age: 34, family: "Lannister")
print("Tyrion is \(tyrion.age) and a \(tyrion.family)")

//: ### ⚠️
//: Tuples are useful for temporary groups of related values. They are not suited to the creation of complex data structures. If your data structure is likely to persist beyond a temporary scope, model it as a class or structure, rather than as a tuple.

//: ## Collection Types
//: ---
//: Three primary collection types - Arrays, Sets, Dictionaries.

//: If you create an array, a set, or a dictionary, and assign it to a variable, the collection that is created will be mutable.
//: If you assign an array, a set, or a dictionary to a constant, that collection is immutable, and its size and contents cannot be changed.

//: ### 😋
//: It is good practice to create immutable collections in all cases where the collection does not need to change. Doing so enables the Swift compiler to optimize the performance of the collections you create.

//: ### Array
//: An array stores values of the same type in an ordered list. The same value can appear in an array multiple times at different positions.

let places: Array<String> = ["Night's Watch", "Winterfell"]

//Empty Array
var families = [String]() //Preferred

print("families is of type [String]. There are \(families.count) families")

//Append
families.append("Stark")

families = [] //Empty again. But still of type [String]
families.isEmpty

families += ["Lannister", "Baratheon"]

//Create array with default value
var someMoreFamilies = [String](count: 2, repeatedValue: "familyName")

//Modify
someMoreFamilies[0] = "Targaryen" //The first item in the array has an index of 0, not 1. Arrays in Swift are always zero-indexed.
someMoreFamilies[1] = "Greyjoy"

families += someMoreFamilies

print("I dont like \(families[3])s")

//Insert
families.insert("Stark", atIndex: 0)

//Remove
families.removeAtIndex(4)

print(families)

families += ["Grejoy", "Martell"]
print(families)

//Subset
families[3...5]

//: ### Sets
//: A set stores distinct values of the same type in a collection with no defined ordering. You can use sets as an alternative to arrays when the order of items is not important, or when you need to ensure that an item only appears once.

var parents = Set<String>()
parents.insert("Eddard")
parents.insert("Catelyn")

//Sets Keep only Unique values
parents.insert("Eddard")

parents.count
parents.isEmpty

print(parents)

var kids = Set(["Robb", "Sansa", "Brandon", "Arya", "Rickon", "Jon"])

// To check if element exists
kids.contains("Sansa")

//Constructing sets
let starks: Set = parents.union(kids)

parents.isSubsetOf(starks)
starks.isSubsetOf(starks)
starks.isStrictSubsetOf(starks)

parents.intersect(kids)
parents.isDisjointWith(kids) //😔

//Mutates the parents set with kids set
parents.unionInPlace(kids)
print(parents);

let getParentsBack = parents.subtract(kids)
print(parents); // Set Parent does not change. 

//Remove By Value
kids.remove("Jon")
kids.removeFirst()

// Empting Sets
parents.removeAll();
//: ### Dictionaries
//: A dictionary stores associations between keys of the same type and values of the same type in an collection with no defined ordering. Each value is associated with a unique key, which acts as an identifier for that value within the dictionary.

var basicSyntax = Dictionary<String, String>()

//Shorthand
var shortHand = [String: String]()
var nickNames: [String: String] = ["KingSlayer": "Jaime Lannister", "Imp": "Tyrion Lannister"]

nickNames.count

//Add
nickNames["Khaleesi"] = "Daenerys Targaryen"
nickNames["Imp"]

let arrayOfNicknames = [String](nickNames.keys)


//: ---
//: [Next](@next)



