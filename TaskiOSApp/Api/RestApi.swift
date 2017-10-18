//
//  RestApi.swift
//  TaskiOSApp
//
//  Created by Chris Worman on 2017-10-16.
//  Copyright © 2017 Chris Worman. All rights reserved.
//

import Foundation

// A wrapper for a rest api that handles serialization and provides standard operations includign GET, POST, DELETE.
class RestApi {
    
    // The base URL of the api (e.g. https://myapi.net)
    private let baseURL: String
    
    // Create a new RestApi with the specified base URL (e.g. https://myapi.net)
    public init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    // HTTP GET using the specified path and query string.  Upon completion, call the specified function with the resulting deserialized object.
    public func get<ResultType:Codable>(pathAndQuery: String, completion: @escaping(_ result: ResultType) -> Void) throws {
        let requestURL = URL(string: baseURL + pathAndQuery)!

        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            
                guard let data = data else { return }
                do {
                    let result: ResultType = try JSONDecoder().decode(ResultType.self, from: data)
                    completion(result)
                } catch {
                    print("Error info: \(error)")
                }
            }.resume()
    }
    
    // HTTP POST using the specified path, query string, and body.  Upon completion, call the specified function with the resulting deserialized object.
    public func post<ResultType:Codable, BodyType:Codable>(pathAndQuery: String, body: BodyType, completion: @escaping(_ result: ResultType) -> Void) throws {
        let requestURL = URL(string: baseURL + pathAndQuery)!
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            
                guard let data = data else { return }
                do {
                    let result: ResultType = try JSONDecoder().decode(ResultType.self, from: data)
                    completion(result)
                } catch {
                    print("Error info: \(error)")
                }
            }.resume()
    }
    
    // HTTP DELETE using the specified path and query string.  Upon completion, call the specified function.
    public func delete(pathAndQuery: String, completion: @escaping() -> Void) throws {
        let requestURL = URL(string: baseURL + pathAndQuery)!
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            completion()
            }.resume()
    }
}
