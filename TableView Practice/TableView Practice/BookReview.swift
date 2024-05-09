//
//  BookReview.swift
//  TableView Practice
//
//  Created by lab on 2/6/24.
//

import Foundation

struct BookReview: Codable {
    var title: String
    var author: String
    var genre: String
    var rating: String
    
    
    static var sampleReviews: [BookReview] =
    [
        BookReview(title: "Wicked Fox", author: "Kat Cho", genre: "Fantasy / Mythology", rating: "10"),
        BookReview(title: "Nyxia", author: "Scott Reintgen", genre: "Sci-Fi", rating: "9"),
        BookReview(title: "Gone", author: "Michael Grant", genre: "Sci-Fi", rating: "10"),
        BookReview(title: "Soul of the Sword", author: "Julie Kagawa", genre: "Fantasy / Mythology", rating: "10"),
        BookReview(title: "The Golden Compass", author: "Philip Pullman", genre: "Fantasy", rating: "8"),
        BookReview(title: "Five Total Strangers", author: "Natalie Richards", genre: "Thriller", rating: "6"),
        BookReview(title: "The Inheritance Games", author: "Jennifer Lynn Barnes", genre: "Mystery", rating: "8"),
        BookReview(title: "City of Bones", author: "Cassandra Clare", genre: "Fantasy", rating: "10"),
        BookReview(title: "Eragon", author: "Christopher Paolini", genre: "Fantasy", rating: "9"),
        BookReview(title: "Sabriel", author: "Garth Nix", genre: "Fantasy", rating: "8"),
        BookReview(title: "Life As We Knew It", author: "Susan Beth Pfeffer", genre: "Sci-Fi", rating: "10"),
        BookReview(title: "Thirteen Reasons Why", author: "Jay Asher", genre: "Mystery", rating: "8"),
        BookReview(title: "Cinder", author: "Marissa Meyer", genre: "Sci-Fi", rating: "10"),
    ]
    
    
    static var archiveURL: URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsURL.appendingPathComponent("reviews").appendingPathExtension("plist")
        return archiveURL
    }
    
    static func saveToFile(reviews: [BookReview]) {
        let encoder = PropertyListEncoder()
        do {
            let encodedReviews = try encoder.encode(reviews)
            try encodedReviews.write(to: archiveURL)
        } catch {
            print("Error when encoding reviews: \(error).")
        }
    }
    
    static func loadFromFile() -> [BookReview]? {
        guard let reviewData = try? Data(contentsOf: archiveURL) else {
            return nil
        }
        do {
            let decoder = PropertyListDecoder()
            let decodedReviews = try decoder.decode([BookReview].self, from: reviewData)
            return decodedReviews
        } catch {
            print("Error decoding reviews: \(error)")
            return nil
        }
    }
}
