//: # Swift Foundation
//: ----

//: ## Control Flow

//: ### For Loops
//: Two kinds: **for-in** and **for**

//For-in
for index in 1...4 {
    print("\(index) times 5 is \(index * 5)")
}

//: In the example above, index is a constant whose value is automatically set at the start of each iteration of the loop. As such, it does not have to be declared before it is used. It is implicitly declared simply by its inclusion in the loop declaration, without the need for a let declaration keyword.

for _ in 1..<4 {
    print("Hello")
}

//Iterate over an array

let checkList = ["Joffrey", "Cersei", "Mountain", "Hound"];

for name in checkList {
    print("Kill \(name)")
}

//Iterate a dictionary

var nickNames: [String: String] = ["KingSlayer": "Jaime Lannister", "Imp": "Tyrion Lannister", "Khaleesi": "Daenerys Targaryen"]

for (nickName, realName) in nickNames {
    print("\(realName) is also known as \(nickName)")
}

//For 
//C-style for loops with a condition and an incrementer
// for initilization; conditon; increment

for var index = 1; index < 4; ++index {
    print("\(index) times 5 is \(index * 5)")
}

//: ###While Loops
//: A while loop performs a set of statements until a condition becomes false. These kinds of loops are best used when the number of iterations is not known before the first iteration begins.

//: **while** evaluates its condition at the start of each pass through the loop.
var index = 1
while index < 5 {
    print("Hello")
    ++index
}

//: **repeat-while** evaluates its condition at the end of each pass through the loop.
repeat {
    print("Hello")
    ++index
} while index < 3

