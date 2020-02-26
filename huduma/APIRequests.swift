//
//  APIRequests.swift
//  huduma
//
//  Created by macbook on 19/02/2020.
//  Copyright © 2020 Arusey. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper


enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}


struct APIRequest {
    let resourceURL: URL
    
    init(endpoint: String) {
        let resourceString = "https://hudumammu.herokuapp.com/api/v1/user/\(endpoint)/"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func save (_ userToSave: User, completion: @escaping(Result<User, APIError>) -> Void) {
        
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userToSave)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest)
            { data, response, _ in
                
                if let data = data { print(String(data: data, encoding: .utf8)!) }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                do {
                    let userData = try JSONDecoder().decode(User.self, from: jsonData)
                    completion(.success(userData))
                }catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }catch {
            completion(.failure(.encodingProblem))
        }
    }
    
}

struct LoginRequest {
    let resourceURL: URL
    
    init(endpoint: String) {
        let resourceString = "https://hudumammu.herokuapp.com/api/v1/user/\(endpoint)/"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError()
        }
        self.resourceURL = resourceURL
    }
    
    func loginUser(_ userToLogin: AuthUser, completion: @escaping(Result<UserToken, APIError>) -> Void) {

        
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userToLogin)
            
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest)
            {
                data, response, _ in
                if let data = data { print(String(data: data, encoding: .utf8)!) }
                
                print("This is the data : \(String(data: data!, encoding: .utf8)!)")

                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200,
                    let jsonData = data else {
                        completion(.failure(.responseProblem))
                        return
                }
                
                do {
                    let userData = try JSONDecoder().decode(UserToken.self, from: jsonData)
                    let saveSuccessful: Bool = KeychainWrapper.standard.set(userData.token, forKey: "token")
                    print("Save was successful: \(saveSuccessful)")
                    completion(.success(userData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
                
                let retrievedString: String? = KeychainWrapper.standard.string(forKey: "token")
                print("The access token is: \(String(describing: retrievedString))")

            }
            dataTask.resume()
            
            
        }
        catch {
            completion(.failure(.encodingProblem))
        }
    }

}



