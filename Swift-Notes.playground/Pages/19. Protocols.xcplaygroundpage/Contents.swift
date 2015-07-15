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

//Note that it is mandatory to fulfill all of protocol's requirements

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





//: ----
//: [Next](@next)
