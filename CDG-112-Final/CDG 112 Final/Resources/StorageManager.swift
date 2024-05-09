//
//  StorageManager.swift
//  CDG 112 Final
//
//  Created by lab on 4/25/24.
//

import FirebaseStorage
import UIKit

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
   public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    //MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void ) {
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
}

public enum UserPostType{
    case photo, video
}
/// Represents a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
}

struct PostLike {
    let username: String
    let postIdentifier: String
}
struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}

enum Gender {
    case male, female, other
}

struct User {
    let username: String
    let name: (first: String, last: String)
    let birthDate: Int
    let gender: Gender
    let bio: String
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}
