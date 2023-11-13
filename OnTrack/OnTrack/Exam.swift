//
//  Exam.swift
//  OnTrack
//
//  Created by Fiyinfoluwa Afolayan on 11/11/23.
//

import Foundation

struct Exam: Codable {
    
    var course: String
    
    var description: String
    
    var dateToBeTaken: Date
    
    init(course: String, description: String, dateToBeTaken: Date = Date()){
        self.course = course
        self.description = description
        self.dateToBeTaken = dateToBeTaken
    }
    var isComplete: Bool = false {
        // Any time a task is completed, update the completedDate accordingly.
        didSet {
            if isComplete {
                // The task has just been marked complete, set the completed date to "right now".
                completedDate = dateToBeTaken
            } else {
                completedDate = nil
            }
        }
    }
    
    private(set) var completedDate: Date?
    
    let createdDate: Date = Date()
    let id: String = UUID().uuidString
}

extension Exam{
    static func save(_ exams: [Exam]) {
        let defaults = UserDefaults.standard
        let encodedData = try! JSONEncoder().encode(exams)
        defaults.set(encodedData, forKey: "Exams")
    }
    
    static func getExams() -> [Exam] {
            let defaults = UserDefaults.standard
            if let data = defaults.data(forKey: "Exams") {
                let decodedExams = try! JSONDecoder().decode([Exam].self, from: data)
                return decodedExams
            }
            else {
                return []
            }
    }
    
    func save() {
        var ExamList = Exam.getExams()
        if let i = ExamList.firstIndex(where: {$0.id == self.id}){
            ExamList.remove(at: i)
            ExamList.insert(self, at: i)
        }
        else{
            ExamList.append(self)
        }
        Exam.save(ExamList)
    }
}
