//
//  HomeworkComposeViewController.swift
//  OnTrack
//
//  Created by Fiyinfoluwa Afolayan on 11/7/23.
//

import UIKit

class HomeworkComposeViewController: UIViewController {

    @IBOutlet weak var homeworkField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var homeworkToEdit: Homework?
    var onComposeHomework: ((Homework) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let homework = homeworkToEdit {
            homeworkField.text = homework.course
            descriptionField.text = homework.description
            datePicker.date = homework.dueDate

            // 2.
            self.title = "Edit Task"
        }
    }
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        guard let course = homeworkField.text,
              !course.isEmpty
        else {
            presentAlert(title: "Oops...", message: "Make sure to add a title!")
            return
        }
        guard let description = descriptionField.text,
              !description.isEmpty
        else {
            // i.
            presentAlert(title: "Oops...", message: "Make sure to add a title!")
            // ii.
            return
        }
        var homework: Homework
        // 3.
        if let editHomework = homeworkToEdit {
            // i.
            homework = editHomework
            // ii.
            homework.course = course
            homework.description = description
            homework.dueDate = datePicker.date
        } else {
            // 4.
            homework = Homework(course: course,
                        description: description,
                        dueDate: datePicker.date)
        }
        // 5.
        onComposeHomework?(homework)
        // 6.
        dismiss(animated: true)
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    private func presentAlert(title: String, message: String) {
        // 1.
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        // 2.
        let okAction = UIAlertAction(title: "OK", style: .default)
        // 3.
        alertController.addAction(okAction)
        // 4.
        present(alertController, animated: true)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
