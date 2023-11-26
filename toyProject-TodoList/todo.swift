//
//  todoData.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/8/23.
//

import Foundation


struct Todo: Codable, Hashable {
    var id: Int
    var title: String
    var description: String
    var completed: Bool
}


