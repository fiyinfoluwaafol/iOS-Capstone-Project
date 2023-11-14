//
//  ExamCell.swift
//  OnTrack
//
//  Created by Fiyinfoluwa Afolayan on 11/11/23.
//

import UIKit
import Foundation

class ExamCell: UITableViewCell {

    @IBOutlet weak var examDetailsLabel: UILabel!
    
    @IBOutlet weak var examDateLabel: UILabel!
    
    var exam: Exam!
    
    func configure(with exam: Exam) {
        // 1.
        self.exam = exam
        // 3.
        update(with: exam)
    }
    
    private func update(with exam: Exam) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        examDetailsLabel.text = exam.course + " | " + exam.description
        examDateLabel.text = "On " + dateFormatter.string(from: exam.dateToBeTaken)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) { }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) { }

}
