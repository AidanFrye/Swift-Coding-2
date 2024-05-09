import UIKit

//make a protocol with an associated response, a generic type for protocols
protocol APIRequest {
    associatedtype Response
    
    var urlRequest: URLRequest { get }
    func decodeResponse(data: Data) throws -> Response
}
//any function that uses this protocol has to have a response of any type, has to get the urlRequest, has to respond with the decoded URL, and has to deal with the error

enum APIRequestError: Error {
    case itemNotFound
}
//make error for failed request

func sendRequest<Request: APIRequest>(_ request: Request) async throws -> Request.Response {
    
    let (data, response) = try await URLSession.shared.data(for: request.urlRequest)
    
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw APIRequestError.itemNotFound
    }
    
    let decodedResponse = try request.decodeResponse(data: data)
    return(decodedResponse)
}
//generic send request, can be used for any type

struct PhotoInfo: Codable {
    var title: String
    var explanation: String
    var url: URL
    var copyright: String?
    
    enum codingKeys: String, CodingKey {
        case title
        case explanation //error was happening, it said no coding key found for description, so i swapped it back to explanation
        case url
        case copyright
    }
}
//create the structure to hold the photo info from the apod

struct PhotoInfoAPIRequest: APIRequest {
    var apiKey: String
    var  urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        urlComponents.queryItems = [URLQueryItem(name: "date", value: "2021-07-15"), URLQueryItem(name: "api_key", value: apiKey)]
        
        return URLRequest(url: urlComponents.url!)
    }
    //code to pull down api request from apod
    
    func decodeResponse(data: Data) throws -> PhotoInfo {
        let photoInfo = try JSONDecoder().decode(PhotoInfo.self, from: data)
        return photoInfo
    }
    //the generic function called with type PhotoInfo
}


struct ImageApiRequest: APIRequest {
    enum ResponseError: Error {
        case invalidImageData
    }
    let url: URL
    
    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }
    func decodeResponse(data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw ResponseError.invalidImageData
        }
        return image
    }
}
//the generic function called with type UIImage

let photoInfoRequest = PhotoInfoAPIRequest(apiKey: "DEMO_KEY")

Task {
    do {
       let photoInfo = try await sendRequest(photoInfoRequest)
        print(photoInfo)
        let imageRequest = ImageApiRequest(url: photoInfo.url)
        let image = try await sendRequest(imageRequest)
    } catch {
        print(error)
    }
}
//call down api requests for desciptions and image
