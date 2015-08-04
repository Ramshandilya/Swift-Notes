//: # Swift Foundation
//: ----
//: ## Access Control
//: ***Access control*** restricts access to parts of your code from code in other source files and modules.  This enables you to hide the implementation details of your code, and to specify a preferred interface through which that code can be accessed and used.

//: ### Terminologies

/*:
----
* ***Module*** is a single unit of code distribution - a framework or an application that is built as a single unit and can be imported with Swift's `import` keyword. E.g. your application itself or a framework like UIKit, Foundation etc. Each build target in Xcode is treated as a separate module in Swift.
----
* ***Source file*** is a single Swift source code within a module.
----
*/



//: ### Access Levels

/*:
Swift provides three levels of access for entities (properties, types, funcitons etc.) within your code.
* ***Public***, meaning anyone can use the entity. It is the highest access level (least restrictive). You typically use public access when specifying the public interface to a framework.
----
* ***Internal***, meaning any code in the same module (application or framework) can use the entity. All entities `internal` by default.
----
* ***Private***, meaning only code in the same source file can use the entity. It is the lowest access level (or most restrictive).
----
*/


//: ## 📖
//: Private access in Swift differs from private access in most other languages, as it’s scoped to the enclosing source file rather than to the enclosing declaration. This means that a type can access any private entities that are defined in the same source file as itself, but an extension cannot access that type’s private members if it’s defined in a separate source file.


//: ### Guiding Principle
//: No entity can be defined in terms of another entity that has a lower (more restrictive) access level. That is, you can’t build a more public entity out of a more private entity.

/*:
For e.g.
* A public variable cannot be defined as having an internal or private type, because the type might not be available everywhere that the public variable is used.
* A function cannot have a higher access level than its parameter types and return type, because the function could be used in situations where its constituent types are not available to the surrounding code.
*/


//: ### Access levels for Single-Target Apps
//: A single target app is typically self-contained within the app and does not need to be made available outside of app's module. The default access level of internal already matches this requirement. Therefore, you do not need to specify a custom access level.

//: ### Syntax

public class PublicClass {}
internal enum InternalEnum {}
private struct PrivateStruct {}


public var somePublicVariable = 10
internal let someInternalConstant = 11

private func somePrivateFunction() {}


//: ## Custom Types
//: The access control level of a type also affects the default access level of that type's members.


// If you define a type’s access level as private, the default access level of its members will also be private.

private class SomePrivateClass {        // explicitly private class
    
    var somePrivateProperty = 0          // implicitly private class member
    
    func somePrivateMethod() {}          // implicitly private class member
}

//: If you define a type’s access level as internal or public (or use the default access level of internal without specifying an access level explicitly), the default access level of the type’s members will be internal.

public class SomePublicClass {          // explicitly public class
    
    public var somePublicProperty = 0    // explicitly public class member
    
    var someInternalProperty = 0         // implicitly internal class member
    
    private func somePrivateMethod() {}  // explicitly private class member
}

class SomeInternalClass {               // implicitly internal class
    
    var someInternalProperty = 0         // implicitly internal class member
    
    private func somePrivateMethod() {}  // explicitly private class member
}

//: ### Tuple types
//: The access level for a tuple type is the most restrictive access level of all types used in that tuple. For example, if you compose a tuple from two different types, one with internal access and one with private access, the access level for that compound tuple type will be private.


//: ## 📖
//: Tuple types do not have a standalone definition in the way that classes, structures, enumerations, and functions do. A tuple type’s access level is deduced automatically when the tuple type is used, and cannot be specified explicitly.

//: ### Function Types
//: The access level for a function type is calculated as the most restrictive access level of the function’s parameter types and return type.

private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    return (SomeInternalClass(), SomePrivateClass())
}

private func anotherFunction(a: SomePrivateClass) {
    
}

func yetAnotherFunction(a: SomeInternalClass, b: SomePublicClass) {
    
}

//: You must specify the access level explicitly as part of the function’s definition if the function’s calculated access level does not match the contextual default.

//: ### Enumeration Types
//: The individual cases of an enumeration automatically receive the same access level as the enumeration they belong to. You cannot specify a different access level for individual enumeration cases.

//Raw values and Associated types
//: The types used for any raw values or associated values in an enumeration definition must have an access level at least as high as the enumeration’s access level. You cannot use a private type as the raw-value type of an enumeration with an internal access level, for example.

//: ### Subclassing
//: A subclass cannot have a higher access level than its superclass—for example, you cannot write a public subclass of an internal superclass.

//: We can override any class member (method, property, initializer, or subscript) that is visible in a certain access context. An override can make an inherited class member more accessible than its superclass version.

public class ClassA {
    private var foo = 10
    private func someMethod() {}
}

internal class ClassB: ClassA {
    override internal func someMethod() {
        
    }
}

//: It is even valid for a subclass member to call a superclass member that has lower access permissions than the subclass member, as long as the call to the superclass’s member takes place within an allowed access level context (that is, within the same source file as the superclass for a private member call, or within the same module as the superclass for an internal member call).

extension ClassB {
    
    func anotherMethod(){
        self.foo = 30
    }
}

//: ### Constants, Variables, Properties and Subscripts
//: A constant, variable, or property cannot be more public than its type. It is not valid to write a public property with a private type, for example. Similarly, a subscript cannot be more public than either its index type or return type.

//: If a constant, variable, property, or subscript makes use of a private type, the constant, variable, property, or subscript must also be marked as private

//let foo = SomePrivateClass() ❌ ERROR !!
private let foo = SomePrivateClass()


//: ### Getters and Setters
//: You can give a setter a lower access level than its corresponding getter, to restrict the read-write scope of that variable, property, or subscript. You assign a lower access level by writing `private(set)` or `internal(set)` before the var or subscript introducer.

struct TextEditor {
    private(set) var numberOfChanges = 0
    
    var text: String = "" {
        didSet {
            numberOfChanges++
        }
    }
}

var vim = TextEditor()
vim.text = "Lorem"
vim.text += " "
vim.text += "Ipsum"

vim.numberOfChanges

//: ### Initalizers
//: Custom initializers can be assigned an access level less than or equal to the type that they initialize. The only exception is for required initializers where it must have the same access level as the class it belongs to.


struct Person { // Internal
    
    private init(){ }
    
    internal init(name: String){ }
    
//    public init(age: String){ } ❌ ERROR !!
    
}

//: ### Default Initializers
//: A default initializer has the same access level as the type it initializes, unless that type is defined as `public`. For a type that is defined as `public`, the default initializer is considered `internal`.

//: ### Default Memberwise Initializers for Structure Types
//: The default memberwise initializer for a structure type is considered private if any of the structure’s stored properties are private. Otherwise, the initializer has an access level of internal.


//: ### Protocols
//: The access level of each requirement within a protocol definition is automatically set to the same access level as the protocol. You cannot set a protocol requirement to a different access level than the protocol it supports.

private protocol Printable {
    var printDescription: String {get set} //Automatically set to private
}

//: ## 📖
//: If you define a public protocol, the protocol’s requirements require a public access level for those requirements when they are implemented.

//: ### Protocol Inheritance
//: If you define a new protocol that inherits from an existing protocol, the new protocol can have at most the same access level as the protocol it inherits from. You cannot write a public protocol that inherits from an internal protocol

//: ### Type Alias
//: A type alias can have an access level less than or equal to the access level of the type it aliases. For example, a private type alias can alias a private, internal, or public type, but a public type alias cannot alias an internal or private type.

//: ----
//: [Next](@next)
