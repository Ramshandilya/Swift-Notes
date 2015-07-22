//: # Swift Foundation
//: ----
//: ## Properties

//: ### Stored Properties
//: Constant/Variable that is stored as a part of the instance of a Class/Structure.

//Stored property can be variable or a constant.

struct Size {
    var width: Int
    let height: Int
}

var windowSize = Size(width: 320, height: 480)
//windowSize.height = 568 //Can't change. Height is declared let.

//Constant instances

let screenSize = Size(width: 640, height: 960)
//screenSize.width = 720

//: It is not possible to change the value of `width` even though it is declared as `var` property. This is because structures are ***value types***. When an instance of a value type is marked as a constant, so are all of its properties.
// Same is not true for classes. (As seen in prev. chapter.)


//: ### Lazy Properties
//: A lazy stored property is a property whose initial value is not calculated until the first time it is used.

/*:
Lazy properties are useful when,
* the initial value is dependent on outside factors whose values are known only after initialization.
* the initial value requires complex computationally expensive setup and that it shouldn't be used unless or until it is required.
*/

//: A stored property is made lazy by adding the `lazy` modifier before its declaration

class TagTeamManager
{
    func setup() {
        //Some complex code
    }
}

class Match
{
    lazy var tagTeamManager = TagTeamManager()
    var matchName: String?
    
    func beginMatchWithPlayersCount(count: Int) {
        if count < 4 {
            //normal match
        } else {
            //Tag Team
            tagTeamManager.setup()
            //TagTeamManager instance is created only now.
        }
    }
}

//: ## 📖
//: Always declare a lazy property as a variable. That's because constant properties must always have a value before initialization completes.

//: ## ⚠️
//: If a lazy property has not been initialized yet, and is accessed by multiple threads simultaneously, there is no guarantee that the property will be created only once.

//: ### Computed Properties
//: Computed properties do not actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly.

import Foundation

struct Cube {
    var edge: Double = 0
    
    var volume: Double {
        get{
            return edge * edge * edge
        }
        set (newVolume){
            let power: Double = (1/3)
            edge = pow(newVolume, power)
        }
    }
}

var someCube = Cube(edge: 3)
someCube.volume

someCube.volume = 125
someCube.edge

// Shorthand setter declaration

struct Square {
    var edge: Double = 0
    
    var area: Double {
        get {
            return edge * edge
        }
        set {
            edge = sqrt(newValue)
        }
    }
}

var someSquare = Square(edge: 3)
someSquare.area

someSquare.area = 25
someSquare.edge

//Read-Only Properties

struct TalkingCube {
    var edge: Double = 0
    
    var volume: Double {
        get {
            return edge * edge * edge
        }
        set {
            let power: Double = (1/3)
            edge = pow(newValue, power)
        }
    }
    
    var description: String {
        get {
            return "Hi! The length of my edge is \(edge)"
        }
    }
    
    //remove get keyword and its braces.
    var simplerDescription: String {
        return "My edge is \(edge)"
    }
}

var niceCube = TalkingCube(edge: 4)
niceCube.description
niceCube.simplerDescription

//: ## ⚠️
//: Computed properties, including read-only properties must be set as a variable and not a constant.

//: ### Property Observers
//: ***Property Observers*** observe and respond to changes of a property's value. Property observers can be added to any stored property except lazy properties.

/*:
* `willSet` is called just before the value is stored.
* `didSet` is called just after the new value is stored.
*/

struct TalkingSquare {
    var edge: Double {
        willSet {
            print("Edge gonna change.")
        }
        didSet {
            print("Edge changed from \(oldValue) to \(edge)")
        }
    }
}

var niceSquare = TalkingSquare(edge: 3)
niceSquare.edge = 5

//: ### Type Properties
//: Properties that belong to the type and not to any one instance of that type. There will only ever be one copy of these properties, no matter how many instances of that type you create.

/*:
* Useful for defining values common to all instances of that type.
* For Value Types (Structs, Enums), you can create stored and computed type properties.
* For Classes, you can create only computed type properties.
* Type properties are defined with the `static` keyword.
* However, for computed type properties in Class types are declared with `class` keyword, to allow subclasses to override
*/

struct Color {
    //stored type property
    static let redColor: (Double, Double, Double) = (1, 0, 0)
    
    //computed type property
    static var oceanColor: (Double, Double, Double) {
        return (0.78, 0.93, 0.98)
    }
}

let drogonColor = Color.redColor
let blackWaterBayColor = Color.oceanColor

class Raven {
    
    //Stored Type Property
    static var eyeColor = "Grey"
    
    //computed Type Property
    static var numberOfWings: Int {
        return 2
    }
    
//    class var numberOfLegs = 10
    
    //Overrideable computed Type Property
    class var numberOfEyes: Int {
        return 2
    }
}

Raven.eyeColor
Raven.numberOfWings
Raven.numberOfEyes
//: ----
//: [Next](@next)
