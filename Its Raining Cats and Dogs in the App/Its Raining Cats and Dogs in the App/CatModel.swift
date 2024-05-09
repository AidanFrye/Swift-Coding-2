import Foundation

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

class CatDataController {
    enum CatInfoError: Error, LocalizedError {
        case itemNotFound
        case imageDataMissing
    }
    
    
    var catInfo: [CatInfo] = []
    var catImages: [CatImage] = []
    
    func fetchCatData() async throws -> [CatInfo] {
        var urlComponents = URLComponents(string: "https://api.thecatapi.com/v1/breeds")!
        urlComponents.queryItems = [
            //put api key and date to pull picture from and use the map closure to add it to the url string
            "api_key": "live_xTZjYl1wGipZlWQMk8ZRFWcBIWYAnYDN2d84s3djq8LxUfc6NUvxgX86xh8VEvVw",
        ].map {URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        let jsonDecoderData = JSONDecoder()
        //guard let to throw errors if recieved
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw CatInfoError.itemNotFound
        }
        catInfo = try jsonDecoderData.decode([CatInfo].self, from: data)
        return catInfo
    }
}
