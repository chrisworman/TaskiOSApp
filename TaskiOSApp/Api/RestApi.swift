//
//  RestApi.swift
//  TaskiOSApp
//
//  Created by Chris Worman on 2017-10-16.
//  Copyright © 2017 Chris Worman. All rights reserved.
//

import Foundation

class RestApi {
    
    private let baseURL: String
    
    public init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    public func get<ResultType:Codable>(urlPathAndQuery: String, completion: @escaping(_ result: ResultType) -> Void) throws {
        let requestURL = URL(string: baseURL + urlPathAndQuery)!

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
    
}
