//: # Swift Foundation
//: ----
//: ## Protocols
//: A ***protocol*** defines a blueprint of methods, properties and other functionalities, which can be adopted by a class, structure or enumerations to provide an actual implementation of the requirements.

//: ## Syntax
/*:
    protocol SomeProtocol {
        //protocol definition
    }

    //Adopting a protocol.

    struct SomeStruct: SomeProtocol {

    }

    //List superclass name before protocols.

    class SomeClass: SuperClass, SomeProtocol, AnotherProtocol {

    }
*/

protocol Fuel {
    var fuelType: String {get set} //Read-write property
    func addFuel() //some method
}

protocol Name {
    var name: String {get} //read-only property
    var manufacturer: String {get} //read-only property
    
    
}

struct Car: Name, Fuel {
    
    let name: String
    var manufacturer: String
    
    var fuelType: String
    
    func addFuel() {
        //some code.
    }
}

//Note that it is mandatory to fulfill all of protocol's requirements.

var swiftCar = Car(name: "Swift", manufacturer: "Maruti Suzuki", fuelType: "Diesel")

struct Rocket: Name, Fuel {
    
    let name: String
    var manufacturer: String
    
    var fuelType: String
    
    func addFuel() {
        //some code.
    }
}

var falcon = Rocket(name: "Falcon", manufacturer: "SpaceX", fuelType: "Rocket Fuel")

//: ## 📖
/*:
* Property requirements are always declared as variable properties, prefixed with the var keyword.
* If a protocol requires a property to be gettable and settable, that property requirement cannot be fulfilled by a constant stored property or a read-only computed property. 
* If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property, and it is valid for the property to be also settable if this is useful for your own code.
*/

falcon.manufacturer = "Telsa"
falcon.manufacturer

//Type property requirements
protocol SomeProtocol {
    static var someProperty: Int {get}
}
//: ## 📖
//: Always prefix type property requirements with `static` keyword inside a protocol.

//: ### Mutating method requirements
//: If you define a protocol instance method requirement that is intended to mutate instances of any type that adopts the protocol, mark the method with the mutating keyword as part of the protocol’s definition.


protocol ChangeDirection {
    mutating func change()
}

enum Direction: ChangeDirection {
    case Forward, Reverse
    
    mutating func change() {
        switch self {
        case .Forward:
            self = .Reverse
        case .Reverse :
            self = .Forward
        }
    }
}

var carDirection = Direction.Forward
carDirection.change()

//: ### Initializer requirements
//: You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the `required` modifier.

protocol AnotherProtocol {
    init(name: String)
}

struct SomeStruct: AnotherProtocol {
    init(name: String){
        
    }
}

class SomeClass: AnotherProtocol {
    required init(name: String) {
        
    }
}

let foo = SomeStruct(name: "Foo")
let bar = SomeClass(name: "Bar")

//: ## 📖
/*:
* `required` ensures that on all subclasses of `SomeClass`, you provide an implementation of the initializer requirement, so the the protocol requirement is fulfilled.

* Therefore, you do not need to mark protocol initializer implementations with the `required` modifier on classes that are marked with the `final` modifier, since `final` classes cannot be subclassed.

*/

//In case the initializer from the superclass matches the initializer from protocol, mark it with both override and required modifiers.

protocol YetAnotherProtocol {
    init()
}

class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, YetAnotherProtocol {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}


//: ### Protocols as Types
//: Any protocol is a full-fledged type.

protocol MyProtocol {
    func quote() -> String
}

class MyClass {
    
    var protocolVariable: MyProtocol
    
    init(fooBar: MyProtocol){
        protocolVariable = fooBar
    }
    
    func anotherMethod() -> String{
        return protocolVariable.quote()
    }
}

class SomeOtherClass: MyProtocol {
    
    func quote() -> String {
        return "You know nothing"
    }
}

let classA = SomeOtherClass()

let classB = MyClass(fooBar: classA)
classB.anotherMethod()


//: ### Delegation
//: ***Delegation*** is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type.

//: Delegation can be used to respond to a particular action, or to retrieve data from an external source without needing to know the underlying type of that source.

protocol TableViewDataSource {
    func numberOfRows() -> Int
}

class TableView {
    var dataSource: TableViewDataSource?
    
    func renderTableView(){
        let rowCount = dataSource?.numberOfRows()
        print("Rows : \(rowCount)")
    }
}

struct MyDataSource: TableViewDataSource {
    func numberOfRows() -> Int {
        return 6
    }
}

let data = MyDataSource()
let table = TableView()
table.dataSource = data

table.renderTableView()


//: ### Adding protocol conformanmce with an Extension
// Existing types can be extendede to adopt and conform to a protocol.

protocol DescriptionProtocol {
    func printDescription() -> String
}

extension TableView: DescriptionProtocol {
    func printDescription() -> String {
        return "Table View Class"
    }
}

extension Int: DescriptionProtocol{
    func printDescription() -> String {
        return "Int Type"
    }
}

let someInt = 3
someInt.printDescription()

//: ## 📖
//: Types do not automatically adopt a protocol just by satisfying its requirements. They must always explicitly declare their adoption of the protocol. 

//: So if a type already conforms to all of a protocol requirements, but has not declared that it adopts that protocol, you can make it adopt the protocl with an empty extension.

struct AnotherStruct {
    func printDescription() -> String {
        return "AnotherStruct Type"
    }
}

extension AnotherStruct: DescriptionProtocol { } //Compiler doesn't complain as the struct has already adopted to the protocol.

//: ### Collections of Protocol Types
//: Protocols can be stored in collection such as Array or Dictionary just like any other types.

let fooBar = AnotherStruct()

let conformedTypes: [DescriptionProtocol] = [someInt, table, fooBar]

for type in conformedTypes {
    type.printDescription()
}


//: ## Protocol Inheritance
//: Protocols can inherit from one or more other protocols and can add further requirements in top of the requirements it inherits.

//: Syntax
/*:
    protocol ProtocolC: ProtocolA, ProtocolB {

    }
*/

protocol PrettyDescription: DescriptionProtocol {
    func printPrettyDescription() -> String
}

extension AnotherStruct: PrettyDescription {
    func printPrettyDescription() -> String {
        return "This is AnotherStruct. Oh yeah!"
    }
}

fooBar.printPrettyDescription()

extension Double: PrettyDescription {
    
    func printPrettyDescription() -> String {
        return "This is Double. Oh yeah!"
    }

    func printDescription() -> String {
        return "Double Type"
    }
}

//: ## 📖
//: It is required to implement `printDescription()` method to satisfy the `PrettyDescription` protocol since it inherits from `DescriptionProtocol`.

//: ### Class-Only Protocols
//: Protocols can limit iteself to be conformed only by Class types and not by Structures or Enumerations. It can be done by adding the `class` keyword to the protocol's inheritance list. The `class` keyword must appear first in inheritance list.

protocol ClassyProtocol: class {
    
}

class MyAnotherClass: ClassyProtocol {
    
}

//struct MyAnotherStruct: ClassyProtocol { } //❌ Compile time ERROR !!

//: ## Protocol Composition
//: Multiple protocols can be combined into a singe requirement. Protocol compositions have the form `protocol<Protocol1, Protocol

protocol ProtocolA { }
protocol ProtocolB { }

struct StructA: ProtocolA, ProtocolB {
    
}

func someMethod(prettyTypes:protocol<ProtocolA, ProtocolB>) {
    
}

let jarjar = StructA()
someMethod(jarjar)

let anakin = MyAnotherClass()
//someMethod(anakin)

//: ### Checking for Protocol Conformance
//: Checking for and casting to a protocol follows the same syntax as checking for a type.

/*:
* `is` operator returns true if an instance conforms to a protocol.
* `as?` returns an optional value of the protocol's type.
* `as!` forces the downcast to the protocol type.
*/

protocol HasName {
    var name: String { get set }
}

class Warrior: HasName {
    var name: String
    
    init(name: String){
        self.name = name
    }

    func description() -> String {
        return "I am a Warrior"
    }
}

class Animal: HasName {
    var name: String
    
    init(name: String){
        self.name = name
    }
}

class CombatSkill{
    var strength: Int
    var agility: Int
    init(strength: Int, agility: Int) {
        self.strength = strength
        self.agility = agility
    }
}

let ned = Warrior(name: "Eddard")
let ghost = Animal(name: "Ghost")
let skill = CombatSkill(strength: 90, agility: 99)

let mixedBag: [Any] = [ned, ghost, skill]

for item in mixedBag {
    if let itemWithName = item as? HasName {
        print(itemWithName.name)
    } else {
        print("Item doesn't have a name")
    }
}

//: ## Protocol Extensions
//: Protocols can be extended to provide method and property implementations to conforming types.

//: This allows us to define behavior on protocols themselves, rather than in each type's individual conformance or in a global function.

extension HasName {
    var greeting: String {
        return "Hi, \(name)"
    }
}

ned.greeting

//: ### Providing Default Implemntations

extension HasName {
    func description() -> String {
        return "I am something which has a name"
    }
}

ned.description() // Has custom implementation of description()
ghost.description() // Uses default implementation from the protocol Extension.

//: ### Adding Constraints to Protocol Extensions
//: We can specify constraints that the conforming types must satisfy before the methods/properties of the extension are available.

protocol HasPopulation {
    var population: Int { get set }
}

class Kingdom: HasName, HasPopulation {
    var name: String
    var population: Int
    
    init(name: String, population: Int){
        self.name = name
        self.population = population
    }
}

extension HasName where Self : HasPopulation {
    func populationDescription() -> String {
        return "\(name) has a population of \(population)"
    }
}

let winterfell = Kingdom(name: "Winterfell", population: 2302)

winterfell.populationDescription()
//ned.populationDescription() // NOT AVAILABLE


//: ----
//: [Next](@next)
