//: # Swift Foundation
//: ----
//: ## Classes and Structures

//: Classes and Structures are the building blocks of object-oriented programming. In Swift, Classes and structures are very close in functionality. 

//But first, let's get some terminologies right.

//Class is a blueprint or a template for an instance of that class.
//Object is an instance of a Class. But since, Classes and stuctures are almost same in Swift, instance is a more generic term.
//Methods are functions that belong to a class or structure. Every method is a function.

/*:
### Classes and Structure can ...
* Define properties to store values
* Define methods to provide functionality
* Define subscripts to provide access to their values using subscript syntax
* Define initializers to set up their initial state
* Be extended to expand their functionality beyond a default implementation
* Conform to protocols to provide standard functionality of a certain kind

### Additional capabilities of a Class
* Inheritance enables one class to inherit the characteristics of another.
* Type casting enables you to check and interpret the type of a class instance at runtime.
* Deinitializers enable an instance of a class to free up any resources it has assigned.
* Reference counting allows more than one reference to a class instance.
*/

//Syntax

struct CombatSkill {
    var strength = 0
    var agility = 0
    var stamina = 0
    var speed = 0
    
    var knowsMagic = false
}

class Warrior{
    var skill = CombatSkill()
    var name: String?
    var nickName: String?
}

//Instances
var fighter = Warrior()
let skill = CombatSkill()

//: The instances `fighter` & `skill` are of type `Warrior` and `CombatSkill` respectively. These are new swift types created when a class/struct is defined.

//: ### Accessing properties

fighter.name = "Arthur Dayne"

fighter.skill.strength = 97
fighter.skill.agility = 98

print(fighter.name!)
print(fighter.skill.strength)
print(fighter.skill.speed)

//: ### Memberwise initializer for Structures

let arthurSkills = CombatSkill(strength: 97, agility: 98, stamina: 89, speed: 90, knowsMagic: false)
fighter.skill = arthurSkills

print(fighter.skill.speed)

//: ## Value Types and Reference Types
//: How values are passed?

//: **Structures are Value Types** and **Classes are Reference Types**

//: A ***value type*** is a type whose value is copied when it is assigned to a variable or constant, or when it is passed to a function.

//All of the basic types in Swift—integers, floating-point numbers, Booleans, strings, arrays and dictionaries—are value types. In fact, they are implemented as structures behind the scenes.

var nedSkills = arthurSkills

//: Since `CombatSkill` is a structure, a copy of the original instance is made and is assigned to `nedSkills`. These are 2 different instances containing same numeric values.

//Let's modify nedSkills.
nedSkills.speed = 82
nedSkills.agility = 78

print(nedSkills.agility)
print(arthurSkills.agility)

//: Unlike value types, ***reference types*** are not copied when they are assigned to a variable or constant, or when they are passed to a function. Rather than a copy, a reference to the same existing instance is used instead.

let eddard = Warrior()
eddard.name = "Eddard"
eddard.skill = nedSkills
eddard.nickName = "Ned"

let anotherNed = eddard
anotherNed.name = "Eddard Stark"

//: Since `Warrior` is a class, `eddard` and `anotherNed` refer to the same `Warrior` instance. 
print(eddard.name!)

//: ## 📖
//: Note that `eddard` and `anotherNed` are declared constants, yet we are able to modify it's properties. That is because `eddard` and `anotherNed` contants themselves do not change and that they dont store the `Warrior` instance, but instead refer to the `Warrior` instance. It is only the property `name` inside `Warrior` that is changed.

//: ----
//: [Next](@next)
