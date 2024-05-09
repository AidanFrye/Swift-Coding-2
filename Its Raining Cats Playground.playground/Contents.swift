import UIKit

struct CatInfo: Codable, CustomStringConvertible {
    var id: String
    var temperament: String
    var desc: String
    var energyLevel: Int
    var origin: String
    var description: String {
        "| NEW CAT INFO ID: \(id), Temperament: \(temperament), Description: \(desc) Energy Level: \(energyLevel), Origin: \(origin), END CAT INFO |"
    }
    //no other variables are needed in the structure
    
    enum CodingKeys: String, CodingKey {
        case id
        case temperament
        case desc = "description"
        case energyLevel = "energy_level"
        case origin
    }
}

struct CatImage: Codable, CustomStringConvertible {
    var width: Int
    var height: Int
    var id: String
    var url: String
    var description: String {
        "URL: \(url)"
    }
}


var catInfo: [CatInfo] = []
var catImages: [CatImage] = []

//condensed fetch photo method as a function rather than a task
func fetchCatData() async throws -> [CatInfo]{
    var urlComponents = URLComponents(string: "https://api.thecatapi.com/v1/breeds")!
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
    catInfo = try jsonDecoderData.decode([CatInfo].self, from: data)
    return catInfo
}

func fetchPhotoData() async throws -> [CatImage] {
    var urlComponentsPhoto = URLComponents(string: "https://api.thecatapi.com/v1/images/search?limit=10")!
    urlComponentsPhoto.queryItems = [
        //put api key and date to pull picture from and use the map closure to add it to the url string
        "api_key": "live_xTZjYl1wGipZlWQMk8ZRFWcBIWYAnYDN2d84s3djq8LxUfc6NUvxgX86xh8VEvVw",
        "breed_ids": "mcoo",
        "limit": "10"
    ].map {URLQueryItem(name: $0.key, value: $0.value) }
    
    let (data, response) = try await URLSession.shared.data(from: urlComponentsPhoto.url!)
    let jsonDecoderData = JSONDecoder()
    //guard let to throw errors if recieved
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw PhotoInfoError.itemNotFound
    }
    catImages = try jsonDecoderData.decode([CatImage].self, from: data)
    return catImages
}

enum PhotoInfoError: Error, LocalizedError {
    case itemNotFound
}

Task {
    do {
        let catInfo = try await fetchCatData()
        print("Successfully fetched CatInfo: \(catInfo)")
    } catch {
        print("Fetch failed with error \(error)")
    }
    do {
        let catImages = try await fetchPhotoData()
        print("Successfully fetched CatImages: \(catImages)")
    } catch {
        print("Fetch failed with error \(error)")
    }
}

