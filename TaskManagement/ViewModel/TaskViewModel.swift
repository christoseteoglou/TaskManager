//
//  TaskViewModel.swift
//  TaskManagement
//
//  Created by Christos Eteoglou on 2023-11-20.
//

import Foundation
import SwiftUI

class TaskViewModel: ObservableObject {
    
    @Published var storedTasks: [Task] = [
    
        Task(taskTitle: "Meeting", taskDescription: "Discuss team task for the day", taskData: 
                .init(timeIntervalSince1970: 1700838915)),
        Task(taskTitle: "Icon set", taskDescription: "Edit icons for team task for next week", taskData:
                .init(timeIntervalSince1970: 1700666212)),
        Task(taskTitle: "Prototype", taskDescription: "Make and send prototype", taskData:
                .init(timeIntervalSince1970: 1700838915)),
        Task(taskTitle: "Check assets", taskDescription: "Start checking the assets", taskData:
                .init(timeIntervalSince1970: 1700499875)),
        Task(taskTitle: "Team party", taskDescription: "Have a great party with the team", taskData:
                .init(timeIntervalSince1970: 1700666212)),
        Task(taskTitle: "Client Meeting", taskDescription: "Explain project to client", taskData:
                .init(timeIntervalSince1970: 1700838915)),
        Task(taskTitle: "Next Project", taskDescription: "Discuss next project with team", taskData:
                .init(timeIntervalSince1970: 1700579812)),
        Task(taskTitle: "App Proposal", taskDescription: "Meet client for next App proposal", taskData:
                .init(timeIntervalSince1970: 1700838915)),
        
    ]
    
    // MARK: Current Week Days
    @Published var currentWeek: [Date] = []
    
    // MARK: Current Day
    @Published var currentDay: Date = Date()
    
    // MARK: Filtering Today Tasks
    @Published var filteredTasks: [Task]? = []
    
    // MARK: Initializing
    init() {
        fetchCurrentWeek()
    }
    
    // MARK: Filter Today Task
    func filterTodayTasks() {
        DispatchQueue.global(qos: .userInteractive).async {
            
            let calendar = Calendar.current
            let filtered = self.storedTasks.filter {
                return calendar.isDate($0.taskData, inSameDayAs: self.currentDay)
            }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current

        // Find the start of the current week
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!

        // Populate currentWeek with days of the current week
        (0..<7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek) {
                currentWeek.append(weekday)
            }
        }
    }
        
    // MARK: Extracting Date
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    // MARK: Check if the current Day is Today
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
    
        return calendar.isDate(currentDay, inSameDayAs: date )
    }
    
    // MARK: Checking if the currentHour is task hour
    func isCurrentHour(date: Date) -> Bool {
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }
}
