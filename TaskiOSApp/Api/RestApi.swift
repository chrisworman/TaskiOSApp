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
        //let testModel = try JSONDecoder().decode(ModelType.self, from: "{\"id\" : 666, \"name\" : \"CW test list\", \"date_modified\" : \"\", \"date_created\" : \"\"}".data(using: .utf8)!)
        //return testModel
        
        let requestURL = URL(string: baseURL + urlPathAndQuery)!
        //var responseString: String = ""
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            
                guard let data = data else { return }
                //responseString = String(data: data, encoding: .utf8)!
                //print(responseString)
                do {
                    let result: ResultType = try JSONDecoder().decode(ResultType.self, from: data)
                    completion(result)
                } catch {
                    print("Error info: \(error)")
                }
            }.resume()
        
        //let responseData = responseString.data(using: .utf8)
        //return try JSONDecoder().decode(ResultType.self, from: responseData!)
    }
    
}
