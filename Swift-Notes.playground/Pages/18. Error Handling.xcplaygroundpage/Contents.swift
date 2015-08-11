//: # Swift Foundation
//: ----
//: ## Error Handling
//: Error handling is the process of responding to and recovering from error conditions in your program. Swift provides first-class support for throwing, catching, propagating, and manipulating recoverable errors at runtime.

//: In Swift, errors are represented by values of types conforming to the `ErrorType` protocol.

enum RavenMessageError: ErrorType {
    case RavenLostMessage
    case RavenDied
    case RavenCapturedByEnemy(returnMessage: String)
}

//: ### Throwing Errors
//: To indicate that a function or method can throw an error, you write the `throws` keyword in its declaration, after its parameters. If it specifies a return type, you write the `throws` keyword before the return arrow (`->`). A function, method, or closure cannot throw an error unless explicitly indicated.

// 🐦✉️
func sendMessage() throws {
    //If Raven lost the message scroll
    throw RavenMessageError.RavenLostMessage
    
//    //If Raven Dies
//    throw RavenMessageError.RavenDied
//    
//    //If Raven is captured by enemy and sends back with a message
//    throw RavenMessageError.RavenCapturedByEnemy(returnMessage: "Muhaha")
}

//: ### Catching and Handling Errors
//: If an error is thrown, that error is propagated to its outer scope until it is handled by a catch clause. A catch clause consists of the catch keyword, followed by a pattern to match the error against and a set of statements to execute.
/*:
    do {
        try someFunctionThatThrows()
        statements
    } catch pattern1 {
        //statements
    } catch pattern2 {
        //statements
    }
*/

do {
    try sendMessage()
    
    //Message Success
    
} catch RavenMessageError.RavenLostMessage {
    print("Raven Lost Message")
} catch RavenMessageError.RavenDied {
    print("Raven Died")
} catch RavenMessageError.RavenCapturedByEnemy(let returnMessage) {
    print("Raven Captured by enemy. Sent back with a message saying \"\(returnMessage)\"")
}

//: ### Disabling Error Propagation
//: There are some cases in which you know a throwing function or method won’t, in fact, throw an error at run time. In these cases, you can call the throwing function or method in a forced-try expression, written, `try!`, instead of a regular `try` expression.

//: This disables error propagation and wraps the call in a run-time assertion that no error will be thrown. If an error actually is thrown, you’ll get a runtime error.

func foo(flag: Bool) throws {
    if flag {
        throw RavenMessageError.RavenDied
    }
}

try! foo(false)

//: ### Defer
//: `defer` lets you execute some code regardless of whether an error occurred. A `defer` statement defers execution until the current scope is exited. 

/*:
    // Some scope starts
    {
        // Get some resource
        
        defer {
            //Release resource
        }

        // Do stuff with the resource.

        // Maybe return early if an error occurs.

    } //Scope Ends. Deferred statements are called when the scope ends.

*/
//: ----
//: [Next](@next)
