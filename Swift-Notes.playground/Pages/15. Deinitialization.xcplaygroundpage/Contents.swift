//: # Swift Foundation
//: ----
//: ## Deinitialization
//: A deinitializer is called immediately before a class instance is deallocated. You write deinitializers with the `deinit` keyword. Deinitializers are only available on class types.

//: The deinitializer does not take any parameters and is written without parentheses.
/*:
    deinit {
        //perform cleanup and deinitialization
    }
*/

/*:
* Deinitializers are called automatically, just before instance deallocation takes place. You are not allowed to call a deinitializer yourself.
* Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer is called automatically at the end of a subclass deinitializer implementation.
* Superclass deinitializers are always called, even if a subclass does not provide its own deinitializer.
* Because an instance is not deallocated until after its deinitializer is called, a deinitializer can access all properties of the instance it is called on and can modify its behavior based on those properties (such as looking up the name of a file that needs to be closed).
*/

struct Casino {
    static var numberOfChips = 100
    
    static func withdrawChips(var numberOfChips: Int) -> Int{
        numberOfChips = min(numberOfChips, self.numberOfChips)
        
        self.numberOfChips -= numberOfChips
        
        return numberOfChips
    }
    
    static func depositChips(numberOfChips: Int) {
        self.numberOfChips += numberOfChips
    }
}

class Gambler {
    var numberOfChips: Int
    
    init(chips: Int){
        numberOfChips = Casino.withdrawChips(chips)
    }
    
    func winChips(chips: Int){
        numberOfChips += Casino.withdrawChips(chips)
    }
    
//    deinit {
//        Casino.depositChips(numberOfChips)
//        print("Deint called")
//    }
}

var foo: Gambler? = Gambler(chips: 45)
foo?.winChips(20)
foo?.numberOfChips

Casino.numberOfChips

foo = nil

Casino.numberOfChips



//: ----
//: [Next](@next)
