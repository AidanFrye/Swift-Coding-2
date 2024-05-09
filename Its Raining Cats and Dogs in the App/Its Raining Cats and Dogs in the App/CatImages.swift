import Foundation
import UIKit


class CatImage: Codable, CustomStringConvertible {
    var width: Int
    var height: Int
    var id: String
    var url: URL
    var description: String {
        "URL: \(url)"
    }
}

class CatImageInfoController {
    enum PhotoInfoError: Error, LocalizedError {
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
            throw PhotoInfoError.itemNotFound
        }
        catInfo = try jsonDecoderData.decode([CatInfo].self, from: data)
        return catInfo
    }
    
    func fetchPhotoData(id: String) async throws -> [CatImage] {
        var urlComponentsPhoto = URLComponents(string: "https://api.thecatapi.com/v1/images/search?limit=1")!
        urlComponentsPhoto.queryItems = [
            //put api key and date to pull picture from and use the map closure to add it to the url string
            "api_key": "live_xTZjYl1wGipZlWQMk8ZRFWcBIWYAnYDN2d84s3djq8LxUfc6NUvxgX86xh8VEvVw",
            "breed_ids": id,
            "limit": "1"
        ].map {URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data, response) = try await URLSession.shared.data(from: urlComponentsPhoto.url!)
        let jsonDecoderData = JSONDecoder()
        //guard let to throw errors if recieved
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PhotoInfoError.itemNotFound
        }
        catImages = try jsonDecoderData.decode([CatImage].self, from: data)
        print(catImages)
        return catImages
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PhotoInfoError.itemNotFound
        }
        guard let image = UIImage(data: data) else {
            throw PhotoInfoError.imageDataMissing
        }
        return image
    }
}
