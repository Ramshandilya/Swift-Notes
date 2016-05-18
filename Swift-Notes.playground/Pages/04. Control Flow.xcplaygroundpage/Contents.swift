//: # Swift Foundation
//: ----
//: ## Control Flow

//: ### For Loops
//: Two kinds: `for-in` and `for`

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

let nickNames: [String: String] = ["KingSlayer": "Jaime Lannister", "Imp": "Tyrion Lannister", "Khaleesi": "Daenerys Targaryen"]

for (nickName, realName) in nickNames {
    print("\(realName) is also known as \(nickName)")
}

//: Each item in the dictionary is returned as a `(key, value)` tuple when the dictionary is iterated, and you can decompose the `(key, value)` tuple’s members as explicitly named constants for use within the body of the for-in loop.


//: Since the value of `index` changes with each iteration, it is declared as `var`.

//: ### While Loops
//: A while loop performs a set of statements until a condition becomes false. These kinds of loops are best used when the number of iterations is not known before the first iteration begins.

//: `while` evaluates its condition at the start of each pass through the loop.
var index = 1
while index < 5 {
    print("Para..para..Paradise!")
    index += 1
}

//: `repeat-while` evaluates its condition at the end of each pass through the loop.
repeat {
    print("Para..para..Paradise!")
    index += 1
} while index < 3


//: ### Conditional Statements

//if

if index == 6 {
    print("SIX!")
}

if index > 6 {
    print("Greater than 6")
} else {
    print("Less than or equal to 6")
}

if index > 6 {
    print("Greater than 6")
} else if index == 6 {
    print("Equal to 6")
} else {
    print("Less than 6")
}


//switch
index = 12

switch index {
case 0:
    print("Zero")
case 1, 2:
    print("1 or 2")
case 3..<7: //Interval matching
    print("3 to 6")
case 7...10: //Interval matching
    print("7 to 10")
default:
    print("Not worth it")
}

//: Notice that there are no `break` statements. No implicit fallthrough. Safer.

//Tuples

let aryaLocation = (33.4, 223.8)

switch aryaLocation {
case (0, 0):
    print("Arya is at origin")
case (_, 0):
    print("Arya is somewhere on the X-Axis line")
case (0, _):
    print("Arya is somewhere on Y-axis line")
case (0..<50, 100...250):
    print("Arya is in Braavos")
default:
    print("Arya is in the middle of nowhere")
}

//: Value binding - A switch case can bind the value or values it matches to temporary constants or variables, for use in the body of the case. This is known as value binding, because the values are “bound” to temporary constants or variables within the case’s body.

switch aryaLocation {
case (let x, 0):
    print("Arya is somewhere on the X-Axis line with x position \(x)")
case (0, let y):
    print("Arya is somewhere on the Y-Axis line with y position \(y)")
case (let x, let y):
    print("Arya is at (\(x), \(y))")
    //default:
    //    print("Default not required in this case since we've exhausted all cases.")
}

// Where

switch aryaLocation {
case let (x, y) where x == y:
    print("Arya is somewhere on the X == Y line")
case let (x, y) where x == -y:
    print("Arya is somewhere on the X == -Y line")
case let (x, y):
    print("Arya is at (\(x), \(y))")
}

//: ### Control Transfer Statements
//: `continue`, `break`, `fallthrough` and `return`

//continue
//: The `continue` statement tells a loop to stop what it is doing and start again at the beginning of the next iteration through the loop.

//break
//: `break` inside a loop statement ends the loop’s execution immediately.
//: `break` inside a `switch` statement causes the switch statement to end its execution immediately.

//: ## ⚠️
//: A switch case that only contains a comment is reported as a compile-time error. Comments are not statements and do not cause a switch case to be ignored. Always use a break statement to ignore a switch case.


//fallthrough
let name = "Sansa"
var description = ""

switch name {
case "Sansa", "Arya":
    description += "\(name) is a Stark"
    fallthrough
default:
    description += " and alive"
}

//Early exit

//: A `guard` statement, like an if statement, executes statements depending on the Boolean value of an expression. You use a guard statement to require that a condition must be true in order for the code after the guard statement to be executed. Unlike an if statement, a guard statement always has an `else` clause—the code inside the `else` clause is executed if the condition is not true.

nickNames

func greetMotherOfDragons() {
    
    guard let name = nickNames["Khaleesi"] else {
        return
    }
    
    print("\(name), How you doin'?")
}

greetMotherOfDragons()


//: ---
//: [Next](@next)
