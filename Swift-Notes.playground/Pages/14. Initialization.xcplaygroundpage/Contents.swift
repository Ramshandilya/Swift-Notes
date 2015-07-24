//: # Swift Foundation
//: ----
//: ## Initialization
//: Initialization is the process of preparing an instance of a class, structure, or enumeration for use.

/*: Consider the following class
    class User {
        var name: String
        var age: Int
    }
*/

//: The above code will throw an error saying that the class has no initializers. Classes and Structures must set its stored properties to an initial value by the time its instance is created.

//One way to shut off the error is to actually set initial values for the properties.
class User {
    var name: String = ""
    var age: Int = 0
}

//: ### Initializer

//: Swift provides a default initializer for any structure or base class that provides default values for all of its properties and does not provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.

let someUser = User() //Calls default Initializer
someUser.name
someUser.age

//Memberwise Initializers for Structure Types
//: Structure types automatically receive a memberwise initializer if they do not define any of their own custom initializers. Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that do not have default values.

struct BirthDate {
    var date: Int
    var month: Int
    var year: Int = 1980
    
    init(){
        date = 1
        month = 1
    }
    
    //Initializer Delegation
    init(year: Int) {
        self.init()
        self.year = year
    }
}

var dateOfBirth = BirthDate()
dateOfBirth.year
dateOfBirth = BirthDate(year: 1995)
dateOfBirth.year

//: Structures provide memberwise initializer by default. But Classes in Swift don't provide default initializers.

//In many cases, the default initializer is not very helpful

class Human {
    let name: String
    var age: Int
    
    init (name: String, age: Int){
        self.name = name //assigning to a constant property
        self.age = age
    }
    
    func greeting () {
        print("Hello, \(name)")
    }
}

//: ## 📖
//: If you define a custom initializer for a value type, you will no longer have access to the default initializer (or the memberwise initializer, if it is a structure) for that type.

//:The following code will throw an error
/*:
    let nicePerson = Human() //Error
*/

let somePerson = Human(name: "Bran", age: 7)
//somePerson.name = "" //ERROR. Cant change constant property
somePerson.age = 8

//: ### Class Inheritance and Initialization
// Some Theory 😩
/*:
Value types (structures and enumerations) do not support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves.

Classes, however, can inherit from other classes. Since all of a class’s stored properties—including any properties the class inherits from its superclass—must be assigned an initial value during initialization. This means that classes have additional responsibilities for ensuring that all stored properties they inherit are assigned a suitable value during initialization.
*/

/*:
Swift provides two kind of initializers to ensure all the stored properties are set to an initial Value.
1. ***Designated Initializers*** -
    * Are primary initializers
    * Initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.
    * Every class must have at least one designated initializer.

2. ***Convenience Initializers*** -
    * Are secondary and supporting initializers for a class.
    * Can call the designated initializer or another convenience initializer of the same class.
    * Not mandatory
*/

//Syntax

/*:
    //Designated Initializer

    init(parameters){
        //statements
    }

    
    //Convenience Initializer

    convenience init(parameters){
        //statements
    }
*/

/*: 
### Initializer Delegation for Class Types
Swift applies three rules for delegation calls between initializer calls.

1. A designated initializer must call a designated initializer from its immediate superclass.

2. A convenience initializer must call another initializer from the *same* class.

3. A convenience initializer must ultimately call a designated initializer.

*/

//: ![Initializer Delegation](initializerDelegation01.png "Initializer Delegation")


//: ----
//: ![Initializer Delegation](initializerDelegation02.png "Initializer Delegation")

/*:
* Designated initializers must always delegate up.
* Convenience initializers must always delegate across.
*/


//: ### Two phase initialization

/*: Class initialization in Swift is a two-phase process.
* First, each stored property is assigned an initial value.
* Then each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.

Hence,
* It prevents property values being accessed before it is initialized
* And prevents property values from being set to a different value by another initializer unexpectedly.
*/

//: ### Safety checks to ensure two-phase initialization

/*:
* A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.

* A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property.

* A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class).

* An initializer cannot call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.
*/

//Enough talk. Let's code

class Person {
    let name: String
    var age: Int
    
    init (name: String, age: Int){
        self.name = name
        self.age = age
    }
    
    convenience init(name: String){
        self.init(name: name, age: 0)
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let hodor = Person(name: "Hodor")
hodor.name
hodor.age

let facelessGod = Person()
facelessGod.name
facelessGod.age

class RoyalPerson: Person {
    var title: String = ""
    
    init (name: String, title: String) {
        self.title = title
        super.init(name: name, age: 0)
    }

    override convenience init(name: String, age: Int) {
        self.init(name: name, title: "Lord")
        self.age = age
    }
    
}

let kingRobert = RoyalPerson(name: "Robert", title: "King")
kingRobert.name
kingRobert.age
kingRobert.title

let jonAryyn = RoyalPerson(name: "Jon")
jonAryyn.name
jonAryyn.title
jonAryyn.age

//: ### Automatic Initializer Inheritance
//: Subclasses do not inherit their superclass initializers by default. However, superclass initializers are automatically inherited if certain conditions are met.
/*:
* If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.

* If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers.
*/

//: ## 📖
//: `RoyalPerson` has it's own designated initializer. Hence it won't inherit the initializers from its superClass. To inherit, it had to override the designated initializer of its superclass.

class Knight: RoyalPerson {
    var combatSkills: Int = 0
    
    
}

let hound = Knight(name: "Sandor", title: "Ser")
hound.name
hound.title

//: ![Initializer Delegation](InitializerDelegation03.png "Initializer Delegation")


//: ## Failable Initializers
//: It is sometimes useful to define a class, structure, or enumeration for which initialization can fail. This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding. 

//: To cope with such initialization failures, we define ***failable initializers***. We define by adding a `?` after `init` like `init?`. Return `nil` to indicate failure.

struct PositiveInteger{
    var integerValue: Int
    
    init?(integer: Int){
        if integer < 0 { return nil }
        integerValue = integer
    }
    
    init(number: Int){
        integerValue = number
    }
}

let someNumber = PositiveInteger(integer:23) //will be of type Optional PositiveInteger
someNumber?.integerValue

let negativeNumber = PositiveInteger(number: -2)
negativeNumber.integerValue

//: 📖
//: You cannot define a failable and a nonfailable initializer with the same parameter types and names.

//Failable initializers for enumerations

enum Boolean {
    case Yes, No
    
    init?(_ boolString: String){
        switch boolString{
        case "Y":
            self = .Yes
        case "N":
            self = .No
        default:
            return nil
        }
    }
}

let amIAwesome = Boolean("Y")
let isThisSessionTooLong = Boolean("N")
let yawn = Boolean("Z")

//Failable initializers for enumerations with Raw Values

enum YesOrNo: Character {
    case Yes = "Y"
    case No = "N"
}

let foo = YesOrNo(rawValue: "Y")
let bar = YesOrNo(rawValue: "X")

//: ### Failable Initializers for Classes
//: For classes, a failable initializer can trigger an initialization failure only after all stored properties introduced by that class have been set to an initial value and any initializer delegation has taken place.

class Place {
    var name: String! //Note the Implicitly unwrapped optional String
    
    init (){
        name = "[Unnamed]"
    }
    
    init?(name: String) {
        self.name = name
        if name == "#" { return nil }
    }
}

let somePlace = Place(name: "Westeros")
somePlace?.name

//Propagation of initialization Failure

class Kingdom: Place {
    var population: Int!
    
    init?(name: String, population: Int){
        self.population = population
        super.init(name: name)
        if population < 1 { return nil }
    }
    
    convenience init?(population: Int){
        self.init()
        self.population = population
    }
    
    override init() {
        self.population = 1
        super.init()
    }
}

let kingdomOfNorth = Kingdom(name: "Winterfell", population: 800)

let someKingdom = Kingdom(name: "#", population: 900)

let anotherKingdom = Kingdom(name: "Dorne", population: 0)

let winterFell = Kingdom(population: 200)

//: 📖
//: Failable initializer must always perform initializer delegation before triggering an initialization failure. A failable initializer can also delegate to a nonfailable initializer.

//: ### Overriding Failable Initializers
//: You can override a superclass failable initializer in a subclass, just like any other initializer. 

//: Alternatively, you can override a superclass failable initializer with a subclass non-failable initializer. This enables you to define a subclass for which initialization cannot fail, even though initialization of the superclass is allowed to fail. But remember, a nonfailable initializer can never delegate to a failable initializer.

//: You cannot override a non-failable initializer with a failable initializer.


// Let's say all southern kingdoms have a min population of 500

class SouthernKingdom: Kingdom {
    
    override init(name: String, population: Int){
        super.init()
        
        if self.population < 500 {
            self.population = 500
        }
        
        if name.isEmpty {
            self.name = "Southern Kingdom"
        } else {
            self.name = name
        }
    }
}

let dorne = SouthernKingdom(name: "Dorne", population: 44) //Result is not an optional
dorne.name
dorne.population


//: ## Required Initializers
//: Write the `required` modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer. You must also write the required modifier before every subclass implementation of a `required` initializer, to indicate that the initializer requirement applies to further subclasses in the chain.

class ClassA {
    required init (){
        
    }
    
    func someMethod(){
        
    }
}

class ClassB: ClassA {
    
    //Subclass init should also have required modifier. NO need to write override.
    required init () {
        
    }
}

//: ### Setting a Default  Property value with a closure or function

let someArray = ["HI"]
class Westeros {
    var kingdoms: [String] = {
       
        var array = someArray
        return array
    }()
    
    var kingdoms2: [String] = {
        
        var array = ["Reach", "Stormlands"]
        return array
        }()
    var greeting: String = {
        return "Hello"
    }()
}

let continent = Westeros()
continent.kingdoms
continent.kingdoms2
continent.greeting
//: ## Finally! 😪

//: ----
//: [Next](@next)
