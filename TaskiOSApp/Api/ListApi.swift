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
    
    private init() {
        restApi = RestApi(baseURL: "http://172.16.1.70:5000")
    }
    
    // Get the shared instance fo the ListApi (i.e. Singleton)
    class func shared() -> ListApi {
        return sharedListApi
    }
    
    // Get all task lists
    public func getAll(completion: @escaping(_ result: [List]) -> Void) throws {
        try restApi.get(pathAndQuery: "/lists", completion: completion)
    }
    
    // Create a new task list
    public func create(newList: List, completion: @escaping(_ result: List) -> Void) throws {
        try restApi.post(pathAndQuery: "/lists", body: newList, completion: completion)
    }
    
    // Delete a list
    public func delete(listId: Int, completion: @escaping() -> Void) throws {
        try restApi.delete(pathAndQuery: String(format: "/lists/%d", listId), completion: completion)
    }
}
