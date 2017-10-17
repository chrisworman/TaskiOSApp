//
//  ListApi.swift
//  TaskiOSApp
//
//  Created by Chris Worman on 2017-10-16.
//  Copyright © 2017 Chris Worman. All rights reserved.
//

import Foundation

class ListApi {
    
    private static let sharedListApi = ListApi()
    
    private let restApi: RestApi
    
    init() {
        restApi = RestApi(baseURL: "http://172.16.1.70:5000")
    }
    
    class func shared() -> ListApi {
        return sharedListApi
    }
    
    public func get(completion: @escaping(_ result: [List]) -> Void) throws {
        try restApi.get(urlPathAndQuery: "/lists", completion: completion)
    }
    
}
