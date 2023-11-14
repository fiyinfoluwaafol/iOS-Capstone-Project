//
//  Task.swift
//  OnTrack
//
//  Created by Fiyinfoluwa Afolayan on 11/13/23.
//

import Foundation
import UIKit

// The Task model
struct Task: Codable {

    // The task's title
    var course: String

    // An optional note
    var description: String

    // The due date by which the task should be completed
    var dueDate: Date

    // Initialize a new task
    // `note` and `dueDate` properties have default values provided if none are passed into the init by the caller.
//    init(course: String, description: String , dueDate: Date = Date()) {
//        self.course = course
//        self.description = description
//        self.dueDate = dueDate
//    }
    init(hw: Homework){
        self.course = hw.course
        self.description = hw.description
        self.dueDate = hw.dueDate
    }
    
    init(exam: Exam){
        self.course = exam.course
        self.description = exam.description
        self.dueDate = exam.dateToBeTaken
    }

    // A boolean to determine if the task has been completed. Defaults to `false`
    var isComplete: Bool = false {

        // Any time a task is completed, update the completedDate accordingly.
        didSet {
            if isComplete {
                // The task has just been marked complete, set the completed date to "right now".
                completedDate = Date()
            } else {
                completedDate = nil
            }
        }
    }

    // The date the task was completed
    // private(set) means this property can only be set from within this struct, but read from anywhere (i.e. public)
    private(set) var completedDate: Date?

    // The date the task was created
    // This property is set as the current date whenever the task is initially created.
    let createdDate: Date = Date()

    // An id (Universal Unique Identifier) used to identify a task.
    let id: String = UUID().uuidString
}

// MARK: - Task + UserDefaults
extension Task {

    // Given an array of tasks, encodes them to data and saves to UserDefaults.
    static func save(_ tasks: [Task]) {

        // TODO: Save the array of tasks
        // 1.
            let defaults = UserDefaults.standard
            // 2.
            let encodedData = try! JSONEncoder().encode(tasks)
            // 3.
            defaults.set(encodedData, forKey: "Tasks")
    }

    // Retrieve an array of saved tasks from UserDefaults.
    static func getTasks() -> [Task] {
        
        // TODO: Get the array of saved tasks from UserDefaults
        // 1.
            let defaults = UserDefaults.standard
            // 2.
            if let data = defaults.data(forKey: "Tasks") {
                // 3.
                let decodedMovies = try! JSONDecoder().decode([Task].self, from: data)
                // 4.
                return decodedMovies
            } else {
                // 5.
                return []
            }
       // return [] // 👈 replace with returned saved tasks
    }

    // Add a new task or update an existing task with the current task.
    func save() {
        var taskList = Task.getTasks()
        
        if let i = taskList.firstIndex(where: {$0.id == self.id}){
            taskList.remove(at: i)
            taskList.insert(self, at: i)
        }
        else{
            taskList.append(self)
        }

        Task.save(taskList)
        // TODO: Save the current task
    }
}
