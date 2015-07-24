//: # Swift Foundation
//: ----
//: ## Automatic Reference Counting
//: Swift uses Automatic Reference Counting (ARC) to track and manage your app’s memory usage. “ ARC automatically frees up the memory used by ***class instances*** when those instances are no longer needed.

//: Reference counting only applies to instances of classes. Structures and enumerations are value types, not reference types, and are not stored and passed by reference.

class Vehicle {
    var numberOfWheels: Int
    
    init() {
        numberOfWheels = 2
        print("Vehicle Init")
    }
    
    deinit {
        print("Vehicle goes Kaboom!")
    }
}

var vehicle1: Vehicle?
var vehicle2: Vehicle?
var vehicle3: Vehicle?

vehicle1 = Vehicle()
//There is now a strong reference from vehicle1 to Vehicle instance.

vehicle2 = vehicle1
vehicle3 = vehicle1

//Now there are 3 strong references to Vehicle instance.

//Let's break 2 of the references

vehicle1?.numberOfWheels = 10
vehicle1?.numberOfWheels
vehicle1 = nil
vehicle2 = nil

//Note that deinit is not yet called. vehicle3 is still holding a strong reference to Vehicle instance.
vehicle3?.numberOfWheels
vehicle3 = nil

//: ### Strong Reference cycles
//: When two class instances hold strong reference to each other, such that each instance is kept alve, it is called as ***strong reference cycle***

//Let's create such a situation

class Pet {
    let name: String
    weak var petOwner: PetOwner?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Pet \(name) is being deinitialized")
    }
}

class PetOwner {
    let name: String
    var pet: Pet?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("PetOwner \(name) is being deinitialized")
    }
}

var ghost: Pet?
var jon: PetOwner?

ghost = Pet(name: "Ghost")
jon = PetOwner(name: "Jon Snow")

//: ![ARC](arc01.png "ARC")

//So far so good.

//Let's get messy

ghost?.petOwner = jon
jon?.pet = ghost

//: ![ARC](arc02.png "ARC")

//Let's break the strong references

ghost = nil
jon = nil

//: ![ARC](arc03.png "ARC")

//: The strong references between the Pet instance and the PetOwner instance remain and cannot be broken and creates a strong reference cycle between them.

//: ## Resolving Strong Reference Cycles between Class Instances
//: Swift provides two ways to resolve strong reference cycles when you work with properties of class type: *weak references* and *unowned references*.

//: ### Weak References
//: ***Weak reference*** is a reference that does not keep a strong hold on the instance it refers to, and so does not stop ARC from disposing of the referenced instance. It is valid for a weak reference to be `nil`. This prevents the reference from being part of strong cycle reference.

//: 📖
/*:
* Weak references must be declared as variables, to indicate that their value can change at runtime. A weak reference cannot be declared as a constant.

* Because weak references are allowed to have “no value”, you must declare every weak reference as having an optional type.
*/


var nymeria: Pet? = Pet(name: "Nymeria")
var arya: PetOwner? = PetOwner(name: "Arya Stark")

nymeria!.petOwner = arya
arya?.pet = nymeria

nymeria = nil

//: ![ARC Weak](arcWeak01.png "ARC Weak")

//: ### Unowned References
//: ***Unowned reference***, like weak references does not hold strong reference to the instance it refers to. But unlike weak reference, an unowned reference is assumed to always have a value. Because of this, an unowned reference is always defined as a non-optional type.


class Warrior {
    let name: String
    var weapon: Weapon?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Warrior \(name) is being deinitialized")
    }
}

class Weapon {
    let name: String
    unowned let weaponOwner: Warrior
    
    init(name: String, owner: Warrior) {
        self.name = name
        weaponOwner = owner
    }
    
    deinit {
        print("Weapon \(name) is being deinitialized")
    }
}

var ned: Warrior? = Warrior(name: "Eddard")
var sword = Weapon(name: "Double Edged Sword", owner: ned!)

ned!.weapon = sword

ned = nil

//: In the above example, a `Warrior` may or may not have a weapon. But a `Weapon` will always be associated with an owner.

//: ## Strong Reference Cycles for Closures
//: Like classes, closures are also reference types. When you assign a closure to a property, you are assigning reference to that closure. So when a class and a closure are having strong reference to each other, we create a strong reference cycle.

//Let's create such a situation

class RoyalPerson {
    var name: String
    var title: String
    
    lazy var greet: Void -> String = {
        
        return "Greetings, \(self.title) \(self.name)"
    }
    
    init(name: String, title: String){
        self.name = name
        self.title = title
    }
    
    deinit {
        print("Royal Person \(title) \(name) deinitialized")
    }
}

var cersei: RoyalPerson? = RoyalPerson(name: "Cersei", title: "Queen")
cersei!.greet()

cersei = nil

//: Notice that after setting `cersei` to `nil`, the denit is still not called. That is because the class and the closure are holding each other.

//: ![ARC Closure](arcClosure01.png "ARC Closure")

//: 📖
//: Even though the closure refers to `self` multiple times, it only captures one strong reference to the `RoyalPerson` instance.

//: ## Resolving Strong References for Closures
//: You resolve a strong reference cycle between a closure and a class instance by defining a ***capture list*** as part of the closure’s definition. A *capture list* defines the rules to use when capturing one or more reference types within the closure’s body.

//: ### Defining a Capture List
//: Each item in a capture list is a pairing of the weak or unowned keyword with a reference to a class instance (such as self) or a variable initialized with some value (such as delegate = self.delegate!).

//: Place the capture list before a closure’s parameter list and return type if they are provided:
/*:
    lazy var someClosure: (Int, String) -> String = {
    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
        // closure body goes here
    }

    lazy var someClosure: Void -> String = {
    [unowned self, weak delegate = self.delegate!] in
        // closure body goes here
    }
*/

//: ![ARC Closure](arcClosure02.png "ARC Closure")

//: ----
//: [Next](@next)
