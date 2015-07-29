//: # Swift Foundation
//: ----
//: ## Type Casting
//: ***Type casting*** is a way to check the type of an instance, and/or to treat that instance as if it is a different superclass or subclass from somewhere else in its own class hierarchy.

//: Type casting is implemented with the `is` and `as` operators.

class Weapon {
    var description: String
    
    init(description: String){
        self.description = description
    }
}

class Sword: Weapon {
    func swordDescription() -> String{
        return "Sword is \(description)"
    }
}

class Bow: Weapon {
    func bowDescription() -> String{
        return "Sword is \(description)"
    }
}

let doubleEdgedSword = Sword(description: "DoubleEdgedSword")
let flamingSword = Sword(description: "FlamingSword")

let longBow = Bow(description: "LongBow")
let crossBow = Bow(description: "CrossBow")

let swords = [doubleEdgedSword, flamingSword] //Array is of type [Sword]
let bows = [longBow, crossBow] //Array is of type [Bow]

let weapons = [doubleEdgedSword, longBow, flamingSword, crossBow] //Array is of type [Weapon]

//: ### Checking Type
//: Use the type check operator (`is`) to check whether an instance is of a certain subclass type. The type check operator returns `true` if the instance is of that subclass type and `false` if it is not.

for item in weapons {
    if item is Sword {
        print(item.description)
    }else if item is Bow {
        print(item.description)
    } else {
        print("Some other type")
    }
}

//: ### Downcasting
//: An instance of a class may actually refer to an instance of a subclass behind the scenes. You can downcast to the subclass type with the ***type cast operator*** (`as?` or `as!`).

/*:
Downcasting have chances of failing, hence the operators comes in two forms
* The conditional form, `as?`, returns an optional value. The value will be nil if the downcast is not successful.
* The forced form, `as!`, attempts the downcast and force-unwraps the result. Use this when you are sure the downcast will succeed.
*/


for item in weapons {
    //Since we are not certain if item is of type Sword or Bow, we use as? operator.
    if let someSword = item as? Sword {
        someSword.swordDescription()
    } else if let someBow = item as? Bow {
        someBow.bowDescription()
    }
}



let weaponsAgain: [Weapon] = [flamingSword, doubleEdgedSword, flamingSword, doubleEdgedSword]

for item in weaponsAgain {
    //In cases where we are sure about the downcasted type, we can use as!.
    let sword = item as! Sword
    
    //We don't need the ! if we try to downcast to the same type as item.
    let weapon = item as Weapon
    
}
//Let's merge the syntax

for item in weaponsAgain as! [Sword] {
    print(item.swordDescription())
}

//: ### Any
//: Swift provides a special type alias for working with non-specific types. `Any` can represent any type at all, including function types.

var things = [Any]()

things.append(1)
things.append(3.14)
things.append("Hi")
things.append((9, 11))
things.append(flamingSword)
things.append(longBow)

things

//: We can use `is` and `as` operators in a `switch` statement's cases 

for thing in things {
    
    switch thing {
    case let someInt as Int:
        print("Array contains an Int with value \(someInt)")
    case let someDouble as Double where someDouble == 2.7:
        print("Array contains an Double with value \(someDouble)")
    case is Double:
        print("Array contains some Double")
    case let someString as String:
        print("Array contains an String with value \(someString)")
    case let (x, y) as (Int, Int):
        print("Array contains an Tuple with value (\(x), \(y))")
    case let someSword as Sword:
        print("Array contains an Sword with \(someSword.swordDescription())")
    case is Bow:
        print("Array contains an Bow")
    default:
        print("Some other type")
    }
}

//: ## 📖1
//: The cases use forced version of type cast, i.e. `as` and not `as?` to check for specific type. This check is always safe within the context of a `switch` case statement.

//: ## 📖2
//: Swift also provides a type alias `AnyObject`. `AnyObject` can represent an instance of any class type. It is mostly used when dealing with Cocoa/CocoaTouch APIs, since we deal with objects of class.

//: ## 📖3
//: Use `Any` and `AnyObject` only when you explicitly need the behavior and capabilities they provide. It is always better to be specific about the types you expect to work with in your code.

//: ----
//: [Next](@next)
