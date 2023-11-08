//
//  Homework.swift
//  OnTrack
//
//  Created by Fiyinfoluwa Afolayan on 11/7/23.
//

import Foundation
import UIKit

struct Homework: Codable {
    
    var course: String
    
    var description: String
    
    var dueDate: Date
    
    init(course: String, description: String, dueDate: Date = Date()){
        self.course = course
        self.description = description
        self.dueDate = dueDate
    }
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
    
    private(set) var completedDate: Date?
    
    let createdDate: Date = Date()
    let id: String = UUID().uuidString
}

extension Homework{
    static func save(_ homeworks: [Homework]) {
        let defaults = UserDefaults.standard
        let encodedData = try! JSONEncoder().encode(homeworks)
        defaults.set(encodedData, forKey: "Homeworks")
    }
    
    static func getTasks() -> [Homework] {
            let defaults = UserDefaults.standard
            if let data = defaults.data(forKey: "Homeworks") {
                let decodedMovies = try! JSONDecoder().decode([Homework].self, from: data)
                return decodedMovies
            } 
            else {
                return []
            }
    }
    
    func save() {
        var homeworkList = Homework.getTasks()
        if let i = homeworkList.firstIndex(where: {$0.id == self.id}){
            homeworkList.remove(at: i)
            homeworkList.insert(self, at: i)
        }
        else{
            homeworkList.append(self)
        }
        Homework.save(homeworkList)
    }
}
