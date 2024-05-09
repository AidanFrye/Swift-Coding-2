import UIKit

struct Note: Codable {  //make new codable struct named note
    let title: String
    let text: String
    let timestamp: Date
}

let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! //initialize fileManager to create saving capabilities

let archiveURL = documentsDirectory.appendingPathComponent("notes").appendingPathExtension("plist")

let newNote = Note(title: "Groceries", text: "Mayo, Mustard, Ketchup, Deli meat, Bread", timestamp: Date()) //make new instance of note
let newNote2 = Note(title: "Study", text: "CDG 112", timestamp: Date()) //make new instance of note
let newNote3 = Note(title: "Play", text: "P3R", timestamp: Date()) //make new instance of note

let notes = [newNote, newNote2, newNote3]

let encoder = PropertyListEncoder() //make new encoder object

let encodedNotes = try? encoder.encode(notes) //encoded notes

try? encodedNotes?.write(to: archiveURL, options: .noFileProtection) //try and catch optional

let decoder = PropertyListDecoder() //create decoder object

let decodedNotesData = try? Data(contentsOf: archiveURL)
let decodedNotes = try? decoder.decode(Array<Note>.self, from: decodedNotesData!)   //decode notes

print(decodedNotes!)
