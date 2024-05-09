import UIKit

//making an extension that calls a random color
extension UIColor {
    static var random: UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

//test extensions
var newColor = UIColor.random
var newColor2 = UIColor.random

//make extension of a string
extension String {
    mutating func addS() {
        let pluralize = self + "s"
        self = pluralize
    }
}

//test string extension
var pet = "dog"
print("I have a \(pet)")
pet.addS()
print("I now have \(Int.random(in:1...10)) \(pet)")

//working with the internet

//create a URL object to start working
let url = URL(string: "https://www.apple.com")!

//asynchronous code, wrapped in a task for the sake of the playground, remove the task in actual apps
Task {
    let (data, response) = try await URLSession.shared.data(from: url)
    //check to see if the website we tried to access actually works before trying to print / work with data
    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
       //print website html
        let string = String(data:data, encoding: .utf8) {
            print(string)
        }
    }

//pulls JSON from website, NASA's API for astronomy picture of the day
var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
urlComponents.queryItems = [
    //put api key and date to pull picture from and use the map closure to add it to the url string
    "api_key": "DEMO_KEY",
    "date": "2024-2-15"
].map {URLQueryItem(name: $0.key, value: $0.value)  }

//runs async function
Task {
    let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
    
    if let httpResponse = response as? HTTPURLResponse,
    httpResponse.statusCode == 200,
       let string = String(data: data, encoding: .utf8)
    {
        print(string)
    }
}
