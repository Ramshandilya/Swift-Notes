//: # Swift Foundation
//: ----
//: ## Methods

//: ***Methods*** are funcitons that are associated with a particular type. Classes, structures, enumerations can all define *instance methods* as well as *type methods*.

class Point {
    var x: Double = 0
    var y: Double = 0
    
    func shiftPointBy(deltaX: Double, deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

//: ### The `self` Property
//: Every instance of a type has an implicit property called `self` which is the equivalent to the instance itself. You use the `self` property to refer to the current instance within its own instance methods.

class Window {
    var width: Double = 0
    var height: Double = 0
    
    func printHeight() {
        print("Height: \(height)");
    }
    
    //Uses self property.
    func printWidth() {
        print("Width: \(self.width)");
    }
}

//: ## 📖
//: You almost never need to explicitly write `self`. Swift assumes you are referring to a property or method of the current instance.

//Except when the parameter name of a method is same as property of that instance. Use self for the property to distinguish from parameter name.

class CGPoint {
    var x: Double = 0
    var y: Double = 0
    
    func shiftPointBy(x: Double, y: Double) {
        self.x += x
        self.y += y
    }
}

//: ### Modifying Value Types within Instance methods
//: By default, the properties of a value type (structs & enums) cannot be modified from within its instance methods. However, if you need to modify, you can opt in for `mutating` behavior.

struct ABPoint {
    var x: Double = 0
    var y: Double = 0
    
    mutating func shiftPointBy(x: Double, y: Double) {
        self.x += x
        self.y += y
    }
}

var location = ABPoint()
print("Location is \(location.x), \(location.y)")
location.shiftPointBy(23, y: 45)
print("Location is \(location.x), \(location.y)")

//Cannot call mutating for a constant structure type.
let fixedLocaiton = ABPoint()
//fixedLocaiton.shiftPointBy(10, y: 10) //ERROR

//: ### Assigning to self withing a mutating method
//: Mutating methods can assign an entirely new instance to the implicit `self` property.

struct XYPoint {
    var x: Double = 0
    var y: Double = 0
    
    mutating func shiftPointBy(x: Double, y: Double) {
        self = XYPoint(x: self.x + x, y: self.y + y)
    }
}

var somePoint = XYPoint(x: 10, y: 10)
somePoint.shiftPointBy(1, y: 1)
print("Location is \(somePoint.x), \(somePoint.y)")

//And for enums

enum TrafficSignal {
    case Red, Yellow, Green
    
    mutating func next () {
        switch self {
        case Red:
            self = Yellow
        case Yellow:
            self = Green
        case Green:
            self = Red
        }
        
        print(self)
    }
}

var signal = TrafficSignal.Red
signal.next()
signal.next()
signal.next()

//: ### Type Methods
//: Similar to type properties, you also define methods on the type itself.

class Knight {
    class func printClass() {
        print("Knight")
    }
}

Knight.printClass()

//: ## 📖
//: Within a type method, `self` refers to the type itself, rather than the instance of the type. Also, any type method can refer other type-level methods and properties.

struct CombatSkill {
    
    var currentSkill = 0
    
    static var maxSkill = 90 //Arthur's skill
    
    static func updateMaxSkillTo(skill: Int) {
        if skill > maxSkill {
            maxSkill = skill
        }
    }
    
    static func isMostSkilled(skill: Int) -> Bool {
        return skill >= maxSkill
    }
    
    
    mutating func levelUpTo(skill: Int) -> Bool {
        if !CombatSkill.isMostSkilled(skill) {
            currentSkill = skill
            return true
        } else {
            return false
        }
    }
    
}


CombatSkill.maxSkill

var nedSkills = CombatSkill(currentSkill: 78)
nedSkills.levelUpTo(91)
nedSkills.currentSkill

CombatSkill.isMostSkilled(nedSkills.currentSkill)

//Then Ned kills Arthur

CombatSkill.updateMaxSkillTo(CombatSkill.maxSkill + 2)

CombatSkill.maxSkill
nedSkills.levelUpTo(91)
nedSkills.currentSkill

CombatSkill.isMostSkilled(nedSkills.currentSkill)


//: ----
//: [Next](@next)
