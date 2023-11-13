//
//  ExamComposeViewController.swift
//  OnTrack
//
//  Created by Fiyinfoluwa Afolayan on 11/11/23.
//

import UIKit

class ExamComposeViewController: UIViewController {
    @IBOutlet weak var courseTextField: UITextField!
    
    @IBOutlet weak var examDescriptionTextField: UITextField!
    
    @IBOutlet weak var dateOfExam: UIDatePicker!
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        guard let course = courseTextField.text,
              !course.isEmpty
        else {
            presentAlert(title: "Oops...", message: "Make sure to add a course name!")
            return
        }
        guard let description = examDescriptionTextField.text,
              !description.isEmpty
        else {
            // i.
            presentAlert(title: "Oops...", message: "Make sure to add an exam description!")
            // ii.
            return
        }
        var exam: Exam
        // 3.
        if let editExam = examToEdit {
            // i.
            exam = editExam
            // ii.
            exam.course = course
            exam.description = description
            exam.dateToBeTaken = dateOfExam.date
        } else {
            // 4.
            exam = Exam(course: course,
                        description: description,
                        dateToBeTaken: dateOfExam.date)
        }
        // 5.
        onComposeExam?(exam)
        // 6.
        dismiss(animated: true)
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    var examToEdit: Exam?
    var onComposeExam: ((Exam) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let exam = examToEdit {
            courseTextField.text = exam.course
            examDescriptionTextField.text = exam.description
            dateOfExam.date = exam.dateToBeTaken

            // 2.
            self.title = "Edit Exam"
        }
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
