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
protocol someProtocol {
    static var someProperty: Int {get}
}
//: ## 📖
//: Always prefix type property requirements with `static` keyword inside a protocol.




//: ----
//: [Next](@next)
