import UIKit

protocol DogGroup { //make our own protocol
    var akcGroup: String { get }
}

struct Dog: CustomStringConvertible, Equatable, Comparable, Codable, DogGroup {
    
    var akcGroup: String    //protocol stub for DogGroup protocol
    
    //make a structure and add a Custom String Convertible protocol, the Equatable protocol, the Comparable protocol, and the Codable protocol
    var description: String { //protocol stub needed for the custom string convertible protocol
        if(age < 5){
            return ("This puppy is a \(breed) named \(name), is \(age) years old, and is part of the \(akcGroup) group.")   //make a description for the protocol to return
        }
        else {
            return ("This dog is a \(breed) named \(name), is \(age) years old, and is part of the \(akcGroup) group.")   //random test to see if you can do multiple returns within a protocol
        }
    }
    var breed: String
    var name: String
    var age: Int
    
    static func ==(lhs: Dog, rhs: Dog) -> Bool {    //protocol stub for equatable protocol, always like this, with a left hand side and a right hand side
        if(lhs.breed == rhs.breed && lhs.name == rhs.name) {    //add logic for checking equivalence of the two sides
            return true
    }
        return false
    }
    static func < (lhs: Dog, rhs: Dog) -> Bool {    //protocol stub for comparable protocol, always like this, in order to implement comparable, you have to conform to equatable
        return lhs.age < rhs.age    //implement only less than, copmuter does the rest, uses age as the comparison factor here
    }
}

var myDog = Dog(akcGroup: "Herding", breed:"Sheltie", name:"Ember", age:3)  //make an object within a structure
var testDog  = Dog( akcGroup: "Hunting", breed:"German_Shepherd", name:"Brutus", age:9)
var myDogCloned = Dog(akcGroup: "Herding", breed:"Sheltie", name:"Ember", age:3)  //clone of ember for testing equatable

print("Ember") //prints name

print(myDog) //prints details about dog
print(testDog) //prints second custom string protocol return

print(myDog == testDog) //returns false because ember and brutus aren't exactly alike
print(myDog == myDogCloned) //returns true because ember is exactly alike a clone of herself

print(myDog > testDog)
print(myDog < testDog)  //test the comparable operator using age as the comparison factor


let jsonEncoder = JSONEncoder() //create encoder for data pull and changing involved with the codable protocol
if let jsonData = try? jsonEncoder.encode(myDog),   //uses try? to dodge errors
   let jsonString = String(data: jsonData, encoding: .utf8) {   //only if the string can be encoded does this statement run
        print(jsonString)
}
