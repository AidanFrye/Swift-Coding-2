import UIKit
/*
//pulls JSON from website, NASA's API for astronomy picture of the day
var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
urlComponents.queryItems = [
    //put api key and date to pull picture from and use the map closure to add it to the url string
    "api_key": "DEMO_KEY",
    "date": "2024-2-20"
].map {URLQueryItem(name: $0.key, value: $0.value)  }

*/
//decode JSON into a structure to drop excess information
struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    //no other variables are needed in the structure
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
}

/*
//runs async function
Task {
    let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
    let jsonDecoder = JSONDecoder()
    if let httpResponse = response as? HTTPURLResponse,
    httpResponse.statusCode == 200,
       let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data)
    {
        print(photoInfo)
    }
 
}*/

//condensed fetch photo method as a function rather than a task
func fetchPhotoData() async throws -> PhotoInfo {
    var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
    urlComponents.queryItems = [
        //put api key and date to pull picture from and use the map closure to add it to the url string
        "api_key": "DEMO_KEY",
        "date": "2024-2-20"
    ].map {URLQueryItem(name: $0.key, value: $0.value) }
    
    let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
    let jsonDecoder = JSONDecoder()
    //guard let to throw errors if recieved
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw PhotoInfoError.itemNotFound
    }
    let photoInfo = try jsonDecoder.decode(PhotoInfo.self, from: data)
    return photoInfo
}

enum PhotoInfoError: Error, LocalizedError {
    case itemNotFound
}

Task {
    do {
        let photoInfo = try await fetchPhotoData()
        print("Successfully fetched PhotoInfo: \(photoInfo)")
    } catch {
        print("Fetch failed with error \(error)")
    }
}
