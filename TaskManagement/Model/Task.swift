//
//  Task.swift
//  TaskManagement
//
//  Created by Christos Eteoglou on 2023-11-20.
//

import Foundation

struct Task: Identifiable {
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskData: Date
}
