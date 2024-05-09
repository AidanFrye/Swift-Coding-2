//
//  AuthManager.swift
//  CDG 112 Final
//
//  Created by lab on 4/25/24.
//

import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    //MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        //check if username is available
        //check if email is available
        //create account
        //insert account to database

        DatabaseManager.shared.canCreateNewUser(with: email, username: username) {canCreate in
            if canCreate {
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        completion(false)
                        return
                    }
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                           // print("yay")
                            completion(true)
                            return
                        }
                        else {
                            print("fail")
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            //email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = username {
            //username log in
            print(username)
        }
    }

    public func logOut(completion: (Bool) -> Void) {
        do {
            completion(true)
            try Auth.auth().signOut()
            return
        }
        catch{
            completion(false)
            print(error)
            return
        }
    }
    
}


