//
//  TaskCell.swift
//  OnTrack
//
//  Created by Fiyinfoluwa Afolayan on 11/13/23.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var task: Task!
    
    func configure(with task: Task) {
        // 1.
        self.task = task
        update(with: task)
    }
    
    private func update(with task: Task) {
        // 1.
        courseLabel.text = task.course
        descriptionLabel.text = task.description
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) { }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) { }

}
