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


//: Access levels for Single-Target Apps
//: A single target app is typically self-contained within the app and does not need to be made available outside of app's module. The default access level of internal already matches this requirement. Therefore, you do not need to specify a custom access level.


//: ----
//: [Next](@next)
