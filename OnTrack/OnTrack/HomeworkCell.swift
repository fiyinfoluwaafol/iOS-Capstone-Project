//
//  HomeworkCell.swift
//  OnTrack
//
//  Created by Fiyinfoluwa Afolayan on 11/7/23.
//

import UIKit

class HomeworkCell: UITableViewCell {

    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    var onCompleteButtonTapped: ((Homework) -> Void)?
    var homework: Homework!
    
    @IBAction func didTapCompleteButton(_ sender: UIButton) {
        homework.isComplete = !homework.isComplete
        
        onCompleteButtonTapped?(task)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
