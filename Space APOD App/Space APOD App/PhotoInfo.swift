//
//  PhotoInfo.swift
//  Space APOD App
//
//  Created by lab on 2/20/24.
//

import Foundation

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

