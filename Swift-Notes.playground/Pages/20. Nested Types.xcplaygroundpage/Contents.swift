//: # Swift Foundation
//: ----
//: ## Nested Types
//: Swift enables you to define *nested types*, whereby you nest enumerations, classes and structures within the definition of the type they support. Types can be nested to as many levels as are required.

struct Message {
    enum Status {
        case Sent
        case Received
        case Read
    }
    
    let sender: String
    let recepient: String
    let message: String
    
    init(sender: String, recepient: String, message: String) {
        self.sender = sender
        self.recepient = recepient
        self.message = message
    }
    var status: Status = .Sent
    
    func printStatus() -> String {
        switch status{
        case .Sent:
            return "Message Sent"
        case .Received:
            return "Message Received"
        case .Read:
            return "Message Read"
        }
    }
}

var message = Message(sender: "Robb", recepient: "Jon Snow", message: "Bran is alive")
message.status = Message.Status.Read

//: ## Nesting Value and Reference Types
//: There are four possible combinations when nesting value and reference types.

//: ### Reference type in a reference type
//: If you have a reference type which contains another reference type, anything which has a reference to either the inner or outer value can manipulate it, as usual. Everyone will see any changes made.

class ClassA {
    var value = 0
    var foo = InnerClass()
    
    class InnerClass {
        var innerValue = 0
    }
}

var outer = ClassA()
var outer2 = outer
outer.value = 10
outer.foo.innerValue = 11

outer2.value
outer2.foo.innerValue

//: ### Value type in a Value type
//: If you have a value type which contains a value type, this makes the outer value bigger. The inner value is part of the outer value. When you assign the outer instance to an other instance, everything get copied, including the inner value. 

struct StructA {
    var value = 0
    var foo = InnerStruct()
    
    struct InnerStruct {
        var innerValue = 0
    }
}

var outer3 = StructA()
var outer4 = outer3

outer3.value = 20
outer3.foo.innerValue = 21

outer4.value
outer4.foo.innerValue

//: ### Value type in a Reference type
//: If you have a reference type which contains a value type, this also makes the referenced value bigger. Anyone with a reference to the outer value can manipulate the whole thing, including the nested value.

class ClassB {
    var value = 0
    var foo = InnerStruct()
    
    struct InnerStruct {
        var innerValue = 0
    }

}

var outer5 = ClassB()
var outer6 = outer5

outer5.value = 30
outer5.foo.innerValue = 31

outer6.value
outer6.foo.innerValue

//Inner is a Value type. 

var outer7 = ClassB()
outer6.foo = outer7.foo

outer6.value
outer6.foo.innerValue


//: ### Reference type in a Value type
//: If you have a value type which contains a reference type, things get interesting. The outer value being value type, gets copied, but the copy has a reference to the same nested type as the original.

struct StructB {
    var value = 0
    var foo = InnerClass()
    
    class InnerClass {
        var innerValue = 0
    }
}

var outer8 = StructB()
var outer9 = outer8

outer8.value = 40
outer9.value

outer8.foo.innerValue = 41
outer9.foo.innerValue // 😰 OUCH!!!

//We are effective breaking value semantics, which can do more bad than good.

//: Hence always be cautious of nesting reference types in a value type. In the ablove example, it is a good indication that the outer type shouldn't be a struct, since we couldn't maintain value semantics.


//: ----
//: [Next](@next)
