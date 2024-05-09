import UIKit

//function that prints a statement

/*

func cooking() {
    print("I'm cooking in my kitchen!")
}

//closure that accepts no parameters and returns no values
//same functionality as the function above

let cookingClosure = { () -> Void in
    print("I'm cooking in my kitchen!")
}

cookingClosure()

//closure that accepts a parameter for what dinner is and returns no values

let cookingDinnerClosure = { (dinner: String) -> Void in
    print("I'm cooking \(dinner) in my kitchen!")
}

cookingDinnerClosure("chicken")

//closure that accepts a parameter and returns a string

let cookingDinnerClosureReturn = { (dinner: String) -> String in
    return "I'm cooking \(dinner) in my kitchen!"
}

let message = cookingDinnerClosureReturn("steak")
print(message)


//make a simple closure

let greeting = {
    print("Hello, world of closures!")
}

let sayGoodbye = {
    print("Goodbye, world of closures!")
}

//send the closure to the function, this makes a shell, and you insert the closure into it

func sayHello(action: () -> Void) {
    print("")
    print("function started")
    action()
    print("function over")
}

//call the closures inside the function

sayHello(action: greeting)
sayHello(action: sayGoodbye)

//you can send anything into a function like this

sayHello
{
    print("look at the custom message yay")
}

//accepting a string in function

func sayHelloString(action: (String) -> String) {
    print("")
    print("function started")
    let message = action("Coding students of AU!")
    print(message)
    print("function over")
}

sayHelloString{ (whoToGreet: String) -> String in
    return "Hello, \(whoToGreet)"
}

*/

//new function that accepts closure and return string

func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

//reduced closure statement

travel { place in
    return "I'm going to \(place) in my car."
}

//premade map closure, performs closure on each object of an array, maps the value to them

let names = ["Johnny", "Nellie", "Aaron", "Rachel"]

let fullNames = names.map{ (name) -> String in
    return name + " Smith"
}

//way to reduce closures to one line, $0 means the first input
//let fullNames = names.map{ return $0 + " Smith"}

print(fullNames)

let numbers = [0, 4, 8, 13, 15, 16, 23, 36, 42]

//filter the numbers who are less than 20

let numLessThan20 = numbers.filter { (number) -> Bool in
    return number < 20
}

//filter the numbers who have a remainder of 0 when divided by 2

let numEven = numbers.filter { (number) -> Bool in
    return number % 2 == 0
}

print (numLessThan20)
print (numEven)

//reduce takes all values in an array and reduces them to one value and returns that

let total = numbers.reduce(0) { (currentTotal, newValue)
    -> Int in
    return currentTotal + newValue
}

print(total)
