import UIKit

//CODE WORKS, ONLY PROBLEM IS IMAGES NOT PULLING DOWN IN AN ARRAY
//decode JSON into a structure to drop excess information
struct DogInfo: Codable, CustomStringConvertible {
    var id: Int
    var name: String
    var bredFor: String?
    var temperament: String?
    var breedGroup: String?
    var origin: String?
    var description: String {
        "| NEW DOG INFO ID: \(id), Temperament: \(temperament ?? "N/A"), Origin: \(origin ?? "N/A"), END DOG INFO |"
    }
    //no other variables are needed in the structure
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case bredFor
        case temperament
        case breedGroup
        case origin
    }
}

struct DogImage: Codable, CustomStringConvertible {
    var width: Int
    var height: Int
    var id: String
    var url: String
    var description: String {
        "URL: \(url)"
    }
}

var dogInfo: [DogInfo] = []
var dogImages: [DogImage] = []

//condensed fetch photo method as a function rather than a task
func fetchDogData() async throws -> [DogInfo] {
    var urlComponents = URLComponents(string: "https://api.thedogapi.com/v1/breeds")!
    urlComponents.queryItems = [
        //put api key and date to pull picture from and use the map closure to add it to the url string
        "api_key": "live_xTZjYl1wGipZlWQMk8ZRFWcBIWYAnYDN2d84s3djq8LxUfc6NUvxgX86xh8VEvVw",
    ].map {URLQueryItem(name: $0.key, value: $0.value) }
    
    let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
    let jsonDecoderData = JSONDecoder()
    //guard let to throw errors if recieved
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw PhotoInfoError.itemNotFound
    }
    dogInfo = try jsonDecoderData.decode([DogInfo].self, from: data)
    return dogInfo
}

func fetchPhotoData() async throws -> [DogImage] {
    var urlComponentsPhoto = URLComponents(string: "https://api.thedogapi.com/v1/images/search?limit=10")!
    urlComponentsPhoto.queryItems = [
        //put api key and date to pull picture from and use the map closure to add it to the url string
        "api_key": "live_xTZjYl1wGipZlWQMk8ZRFWcBIWYAnYDN2d84s3djq8LxUfc6NUvxgX86xh8VEvVw",
        "id": "1",
        "limit": "10",
    ].map {URLQueryItem(name: $0.key, value: $0.value) }
    
    let (data, response) = try await URLSession.shared.data(from: urlComponentsPhoto.url!)
    let jsonDecoderData = JSONDecoder()
    //guard let to throw errors if recieved
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw PhotoInfoError.itemNotFound
    }
    dogImages = try jsonDecoderData.decode([DogImage].self, from: data)
    return dogImages
}

enum PhotoInfoError: Error, LocalizedError {
    case itemNotFound
}

Task {
    do {
        let dogInfo = try await fetchDogData()
        print("Successfully fetched DogInfo: \(dogInfo)")
    } catch {
        print("Fetch failed with error \(error)")
    }
    do {
        let dogImages = try await fetchPhotoData()
        print("Successfully fetched DogImages: \(dogImages)")
    } catch {
        print("Fetch failed with error \(error)")
    }
}

