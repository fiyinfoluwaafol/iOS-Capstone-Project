//
//  HomeworkCell.swift
//  OnTrack
//
//  Created by Fiyinfoluwa Afolayan on 11/7/23.
//

import UIKit
import Foundation

class HomeworkCell: UITableViewCell {

    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var completeButton: UIButton!
    
    
    var onCompleteButtonTapped: ((Homework) -> Void)?
    var homework: Homework!
    
    @IBAction func didTapCompleteButton(_ sender: UIButton) {
        homework.isComplete = !homework.isComplete
        update(with: homework)
        onCompleteButtonTapped?(homework)
    }
    
    func configure(with homework: Homework, onCompleteButtonTapped: ((Homework) -> Void)?) {
        // 1.
        self.homework = homework
        // 2.
        self.onCompleteButtonTapped = onCompleteButtonTapped
        // 3.
        update(with: homework)
    }
    
    private func update(with homework: Homework) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        courseLabel.text = homework.course
        descriptionLabel.text = homework.description
        dueDateLabel.text = "Due by " + dateFormatter.string(from: homework.dueDate)
        // 3.
        courseLabel.textColor = homework.isComplete ? .secondaryLabel : .label
        // 4.
        completeButton.isSelected = homework.isComplete
        // 5.
        completeButton.tintColor = homework.isComplete ? .systemBlue : .tertiaryLabel
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) { }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) { }

}
