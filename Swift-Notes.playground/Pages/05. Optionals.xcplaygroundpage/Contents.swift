//: # Swift Foundation
//: ----
//: ## Optionals

//Consider the following code

let checkList = ["Joffrey", "Cersei", "Mountain", "Hound"];

func findName(name: String, list: [String]) -> String {
    
    for item in checkList {
        if name == item {
            return name
        }
    }
    
    return ""
}

findName("Hound", list: checkList)

//What happens when the value is not found?
findName("Meryn", list: checkList)

//It would be nice to return **nil**. But returning nil will result in a compile error since the return is of String type.

//: ### Enter optionals

//: An optional is a type that can have two states. a value or `nil`.

//: ## 💪
//: The concept of optionals doesn’t exist in C or Objective-C. The nearest thing in Objective-C is the ability to return nil from a method that would otherwise return an object, with nil meaning “the absence of a valid object.” However, this only works for objects—it doesn’t work for structures, basic C types, or enumeration values. Swift’s optionals let you indicate the absence of a value for ***any type at all***, without the need for special constants (like NSNotFound).

//To declare an optional, simply suffix with a ?

func findPerson(name: String, list: [String]) -> String? {
    
    for item in checkList {
        if name == item {
            return name
        }
    }
    return nil
}

let culprit = findPerson("Hound", list: checkList)
//culprit is of type String? (read Optional String) and not String

//String type can contain only strings.
//String? type can contain string value or nil.

//: ## 📖
//: `nil` cannot be used with nonoptional constants and variables. If a constant or variable in your code needs to work with the absence of a value under certain conditions, always declare it as an optional value of the appropriate type.

var someName: String? //someName is automatically set to nil
//: ## 📖
//: Swift’s nil is not the same as nil in Objective-C. In Objective-C, nil is a pointer to a nonexistent object. In Swift, nil is not a pointer—it is the absence of a value of a certain type. Optionals of any type can be set to nil, not just object types.


//If statement and forced unwrapping

if someName == nil {
    someName = "Rhaegar"
}

print("Name is \(someName)")

print("Name is \(someName!)")

//: ## ⚠️
//: Trying to use ! to access a non-existent optional value triggers a runtime error. Always make sure that an optional contains a non-nil value before using ! to force-unwrap its value.

//: ### Optional Binding
//: Optional binding can be used with `if` and `while` statements to check for a value inside an optional, and to extract that value into a constant or variable

if let name = someName {
    print("Name is \(name)") //name is a String. Not an optional
}


//Multiple optional bindings

let someOtherName: String? = "Lyanna"

if let name = someName, anotherName = someOtherName {
    
}

//: ### Implicitly Unwrapped Optionals
//: Sometimes it is clear from a program’s structure that an optional will always have a value, after that value is first set. In these cases, it is useful to remove the need to check and unwrap the optional’s value every time it is accessed, because it can be safely assumed to have a value all of the time.

//: These kinds of optionals are defined as ***Implicitly Unwrapped Optionals***. You declare by suffixing with a ***!*** rather than a ***?***

let forcedName: String = someName! //String

let assumedName: String! = "Jon" //Implicitly Unwrapped Optional string
let implicitName = assumedName //No need of "!" suffix

//: An implicitly unwrapped optional is a normal optional behind the scenes, but can also be used like a nonoptional value, without the need to unwrap the optional value each time it is accessed.

//: ## ⚠️
//: If you try to access an implicitly unwrapped optional when it does not contain a value, you will trigger a runtime error. The result is exactly the same as if you place an exclamation mark after a normal optional that does not contain a value.

//: ## 😋
//: Optionals help save a lot of time and make our code readable and efficient. It might take a little getting used to but once you get the hang of it you would hate to have code lying around that explicitly checks for nils or sentinel values.


//: ---
//: [Next](@next)
