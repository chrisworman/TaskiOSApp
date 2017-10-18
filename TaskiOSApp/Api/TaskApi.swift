//
//  TaskApi.swift
//  TaskiOSApp
//
//  Created by Chris Worman on 2017-10-16.
//  Copyright © 2017 Chris Worman. All rights reserved.
//

import Foundation

class TaskApi {
    
    private static let sharedTaskApi = TaskApi()
    
    private let restApi: RestApi
    
    private init() {
        restApi = RestApi(baseURL: "http://172.16.1.70:5000")
    }
    
    // Get the shared instance of the TaskApi  (i.e. Singleton)
    class func shared() -> TaskApi {
        return sharedTaskApi
    }
    
    // Get the tasks that are on a list
    public func getByListId(listId: Int, completion: @escaping(_ result: [Task]) -> Void) throws {
        try restApi.get(pathAndQuery: String(format:"/tasks?list_id=%d", listId), completion: completion)
    }
    
    // Create a new task
    public func create(newTask: Task, completion: @escaping(_ result: Task) -> Void) throws {
        try restApi.post(pathAndQuery: "/tasks", body: newTask, completion: completion)
    }
    
    // Delete a task
    public func delete(taskId: Int, completion: @escaping() -> Void) throws {
        try restApi.delete(pathAndQuery: String(format: "/tasks/%d", taskId), completion: completion)
    }
}
