//: # Swift Foundation
//: ----
//: ## Optional Chaining
//: ***Optional chaining*** is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil.

/*:
Optional chaining return two values

* if the optional contains a 'value' then calling its related property, methods and subscripts returns values

* if the optional contains a 'nil' value all its its related property, methods and subscripts returns nil

*/

//: In simpler words, Optional chaining makes it easy to dig into multiple levels of optional values.  Implicitly unwrapped (Forced unwrapped) optionals, while not as safe as normal optionals, are often used under the assumption that the value that it is describing is never, or usually not, nil. 

class PetOwner {
    
    var pet: Pet?
    
}

class Pet {
    var name: String
    var favoriteFood: PetFood?
    var allFoods = [PetFood]()
    
    init(name: String){
        self.name = name
    }
    
    subscript(index: Int) -> PetFood {
        
        get {
            return allFoods[index]
        }
        set {
            allFoods[index] = newValue
        }
    }
}

class PetFood {
    var foodName: String = ""
    
    func printFood() {
        print("Fav food is \(foodName)")
    }
}

let arya = PetOwner()

let nymeriaFood = arya.pet?.favoriteFood?.foodName //Result is of type String?

//: Because the attempt to access `foodName` has the potential to fail, the optional chaining attempt returns a value of type String?, or “optional String”. Note that this is true even if `foodName` is a non-optional String.

arya.pet = Pet(name: "Nymeria") //(1)
arya.pet?.favoriteFood = PetFood() //(2)
arya.pet?.favoriteFood?.foodName = "Chicken"

//Let's comment out lines (1) and (2) one by one and see the result.

if let favFood = arya.pet?.favoriteFood?.foodName {
    print("Fav. food is \(favFood)")
} else {
    print("No fav. food 😔")
}

//: Instead of writing a series of `if let` checks to extract the value, Swift makes it easier and with less code by *Optional Chaining*. 

//: ### Accessing methods through optional chaining

if arya.pet?.favoriteFood?.printFood() != nil {
    print("Fav. food was printed")
} else {
    print("Could not print fav. food 😔")
}

//: The functiona `printFood()` doesn't return a value. But functions with no return type have an implicit return type of `Void` or an empty tuple `()`.

//: Hence the resultant value will be of type `Void?` since the result of optional chaining is always an optional.


//: ### Accessing subscripts through optional chaining

arya.pet?.allFoods.append(PetFood())
let someFood = arya.pet?[0] //Place the ? before the square braces.
//someFood is of type PetFood?
someFood?.foodName

//Accessing subscripts of optional type
//: Place the question mark after the subscript’s closing bracket to chain on its optional return value

let knights = ["Arthur": [98,90,93], "Barriston": [89,86,84]]
knights["Arthur"]?[0]


//: ----
//: [Next](@next)
