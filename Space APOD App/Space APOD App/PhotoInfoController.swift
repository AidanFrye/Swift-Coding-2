//
//  PhotoInfoController.swift
//  Space APOD App
//
//  Created by lab on 2/20/24.
//

import Foundation
import UIKit

struct PhotoInfoController {
    enum PhotoInfoError: Error, LocalizedError {
        case itemNotFound
        case imageDataMissing
    }
    
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
    func fetchPhotoData(date: String) async throws -> PhotoInfo {
        var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        urlComponents.queryItems = [
            //put api key and date to pull picture from and use the map closure to add it to the url string
            "api_key": "DEMO_KEY",
            "date": "\(date)"
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

