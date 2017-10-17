//
//  List.swift
//  TaskiOSApp
//
//  Created by Chris Worman on 2017-10-16.
//  Copyright © 2017 Chris Worman. All rights reserved.
//

import Foundation

public struct List: Codable {
    public let id: Int
    public let name:String
    public let date_created: String
    public let date_modified: String
}
