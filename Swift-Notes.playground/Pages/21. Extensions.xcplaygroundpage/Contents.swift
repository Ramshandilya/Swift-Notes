//: # Swift Foundation
//: ----
//: ## Extensions
//: ***Extensions*** add new functionality to an existing class, structure, enumeration, or protocol type.

/*:
Extensions can
* Add computed properties and computed type properties
* Define instance methods and type methods
* Provide new initializers
* Define subscripts
* Define and use new nested types
* Make an existing type conform to a protocol
*/


//: ## 📖
//: Extensions can add new functionality to a type, but they cannot override existing functionality.

//: ### Syntax
/*:
    extension SomeType {
        // new functionality to add to SomeType goes here
    }
*/

//: ### Computed Properties

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
    var inch: Double { return self/39.37}
}

let threeKm = 3.km
print("3km is \(threeKm) meters")

let height = 5.ft + 9.inch
print("My height is \(height) meters")

//: ## 📖
//: Extensions can add new computed properties, but they cannot add stored properties, or add property observers to existing properties.

//: ### Initializers

struct CombatSkill {
    var strength = 0
    var agility = 0
    var stamina = 0
    var speed = 0
    
    var knowsMagic = false
}

extension CombatSkill {
    
    init(strength: Int) {
        self.init(strength: strength, agility: 50, stamina: 50, speed: 50, knowsMagic: false)
    }
}

let c = CombatSkill(strength: 90)
c.agility

//: ## 📖
//: Extensions can add new convenience initializers to a class, but they cannot add new designated initializers or deinitializers to a class.


//: ### Methods

extension Int {
    func repeatTask(someTask: () -> Void) {
        for _ in 0 ..< self {
            someTask()
        }
    }
}

3.repeatTask { print("Hodor") }


//: ### Mutating methods
//: Instance methods added with an extension can also mutate the instance itself. SUch extensions have to be marked as `mutating`.

extension Int {
    mutating func cube(){
        self = self * self * self
    }
}

var four = 4
four.cube()

//: ### Subscripts

extension Int {
    subscript (index: Int) -> Int {
        return self * index
    }
}

four
four[2]

//: ### Nested Types

extension Int {
    
    enum Sign{
        case Negative
        case Zero
        case Positive
    }
    
    var sign: Sign {
        
        switch self {
        case 0:
            return .Zero
        case let x where x<0:
            return .Negative
        default:
            return .Positive
        }
    }
}

let someNumber = -4
someNumber.sign
let anotherNumber = 4
anotherNumber.sign
let zero = 0
zero.sign




//: ----
//: [Next](@next)
