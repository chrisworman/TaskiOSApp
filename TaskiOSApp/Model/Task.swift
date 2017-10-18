//
//  Task.swift
//  TaskiOSApp
//
//  Created by Chris Worman on 2017-10-16.
//  Copyright © 2017 Chris Worman. All rights reserved.
//

import Foundation

public struct Task: Codable {
    public var id: Int
    public var list_id: Int
    public var text: String
    public var marked: Bool
    public var date_created: String
    public var date_modified: String
}
