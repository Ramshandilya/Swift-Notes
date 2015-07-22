//: # Swift Foundation
//: ----
//: ## Inheritance
//: A class can inherit methods, properties, and other characteristics from another class.

/*:
When one class inherits from another class,
* the inheriting class is called as the ***subclass***
* and the class it inherits from is the ***superclass***

Subclass can
* call and access methods, properties, subscripts belonging to its superclass.
* override methods, properties, subscripts.
* add property observers to inherited properties.
*/

//: ### Base Class

//: Any class that doesn't inherit from another class is a ***base class***

class BaseClass {
    var someProperty = 1
    
    func someMethod() -> String {
        return "Hi"
    }
}

//: ### Subclassing

class SubClassA: BaseClass {
    
    var anotherProperty = 2
}

class SubClassB: SubClassA {
    
}

let temp = SubClassA()
temp.anotherProperty
temp.someProperty
temp.someMethod()

let temp2 = SubClassB()
temp2.anotherProperty
temp2.someProperty
temp2.someMethod()

//: ### Overriding
//: A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript that it would otherwise inherit from a superclass. This is known as overriding.

/*:
* Prefix the overriding definition with an `override` keyword.
* Adding `override` keyword clarifies that you have not provided matching definition by mistake.
* Any overrides without `override` keyword is a compiler error.
* Allows Swift to check if the *superclass* has the same matching declaration.
*/

class ClassA {
    
    var storedProperty: Int = 10
    
    var computedProperty: Int {
        get{
            return storedProperty + 2
        }
        set {
            storedProperty = newValue - 2
        }
    }
    
    var anotherComputedProperty: Int {
        return storedProperty + 5
    }
    
    func someMethod() {
        print("Hello")
    }
}

class ClassB: ClassA {
    var normalProperty: Int = 20
    
    override var computedProperty: Int {
        get{
            return normalProperty + 3
        }
        set {
            normalProperty = newValue - 3
        }
    }
    
    override var anotherComputedProperty: Int {
        get {
            return normalProperty + 5
        } set {
            normalProperty = newValue - 5
        }
    }
}

var foo = ClassA()
foo.storedProperty
foo.computedProperty
foo.computedProperty = 20
foo.storedProperty

var bar = ClassB()
bar.storedProperty
bar.computedProperty
bar.anotherComputedProperty
bar.anotherComputedProperty = 15
bar.normalProperty


//: ### Overriding Property observers
//: You can use property overriding to add property observers to an inherited property.

class ClassC: ClassA {
    
    override var storedProperty: Int {
        willSet {
          print("normalProperty is about to change")
        }
        didSet {
            print("normalProperty changed")
        }
    }
    
    //Can't override read-only computed property
//    override var anotherComputedProperty: Int {
//        willSet {
//            print("normalProperty is about to change")
//        }
//        didSet {
//            print("normalProperty changed")
//        }
//    }
    
}

var fooBar = ClassC()
//fooBar.storedProperty = 30

//: ## 📖
//: You cannot add property observers to inherited constant stored properties and inherited read only computed properties. The values of these properties cannot change, hence not appropriate to have `willSet` and `didSet`.

//: ### Preventing Overrides & Subclass
/*: 
* You can prevent a method, property, or subscript from being overridden by marking it as final.
* You can also prevent a class from being subclassed by marking it as final.
* Do this by prefixing with `final` keyword before the definition
*/

final class ClassD: ClassC {
    final var someProperty = 10
    
    final func description() {
        
    }
}

//Can't create a subclass of ClassD, since it is marked sa final.

//class ClassE: ClassD {
//    override func description() {
//        
//    }
//}


//: ----
//: [Next](@next)
