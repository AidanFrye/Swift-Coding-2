import UIKit

//Name: Aidan Frye
//Last Modified: Jan 17

struct Human: CustomStringConvertible, Equatable, Comparable, Codable {
    var name:String
    var age:Int
    
    var description: String
    {
        return ("This person is named \(name), and is \(age) years old.")
    }
    static func ==(lhs: Human, rhs: Human) -> Bool {
        if(lhs.age == rhs.age && lhs.name == rhs.name) {
            return true
        }
        return false
    }
    static func < (lhs: Human, rhs: Human) -> Bool {
        return lhs.age < rhs.age
    }
}

let aidan = Human(name:"Aidan", age:19)
let owen = Human(name:"Owen", age:16)
let beckett = Human(name:"Beckett", age: 13)
let maggie = Human(name:"Maggie", age:19)
let michael = Human(name:"Michael", age:21)

print(aidan)
print(aidan == owen)
print(aidan != owen)

var people: [Human] = [owen, aidan, beckett, maggie, michael]

let sortedPeople = people.sorted(by: <)

let jsonEncoder = JSONEncoder()

if let jsonData = try? jsonEncoder.encode(aidan),
   let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString)
}

protocol Vehicle {
    var numberOfWheels: Int { get }
    func drive()
}
    
struct Car: Vehicle, CustomStringConvertible {
    var description: String{
        return ("This car has \(numberOfWheels) wheels!")
    }
    
    var numberOfWheels: Int {
        return 4
    }
    
    func drive() {
        print("Vroom, vroom!")
    }
}

let myCar = Car()

print(myCar)
myCar.drive()

struct Bike: Vehicle, CustomStringConvertible {
    var description: String{
        return ("This bike has \(numberOfWheels) wheels!")
    }
    var numberOfWheels: Int {
        return 2
    }
    
    func drive() {
        print("Begin pedaling!")
    }
}

let myBike = Bike()

print(myBike)
myBike.drive()
