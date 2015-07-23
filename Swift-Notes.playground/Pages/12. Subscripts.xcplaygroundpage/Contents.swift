//: # Swift Foundation
//: ----
//: ## Subscripts
//: Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence.

//For eg. you access an element of an array at index by array[index].

struct DaysOfWeek {
    
    var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    subscript(index: Int) -> String {
        get {
            return days[index]
        }
        set {
            days[index] = newValue
        }
    }
}

var week = DaysOfWeek()
week[1]
week[0]
week[0] = "Sunday"
week[0]

//: ### Subscript Options
//: Subscripts can take any number of input parameters, and these input parameters can be of any type. Subscripts can also return any type. Subscripts can use variable parameters and variadic parameters, but cannot use in-out parameters or provide default parameter values.

struct Food {
    
    enum MealTime {
        case Breakfast, Lunch, Dinner
    }
    
    var meals: [MealTime: String] = [:]
    
    subscript (type: MealTime) -> String? {
        get {
            return meals[type]
        }
        set {
            meals[type] = newValue
        }
    }
}

var diet = Food()
diet[.Breakfast] = "Scrambled Eggs"
diet[.Lunch] = "Rice"

print("I had \(diet[.Breakfast]) for breakfast")


//: ----
//: [Next](@next)
