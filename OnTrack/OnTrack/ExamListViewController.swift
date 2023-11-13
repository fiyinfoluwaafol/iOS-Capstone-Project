//
//  ExamListViewController.swift
//  OnTrack
//
//  Created by Fiyinfoluwa Afolayan on 11/11/23.
//

import UIKit

class ExamListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    var exams = [Exam]()
    
    @IBAction func didTapNewExamButton(_ sender: Any) {
        performSegue(withIdentifier: "ComposeExamSegue", sender: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableHeaderView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        refreshExams()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ComposeExamSegue" {
            if let composeNavController = segue.destination as? UINavigationController,
               let examComposeViewController = composeNavController.topViewController as? ExamComposeViewController {
                examComposeViewController.examToEdit = sender as? Exam
                examComposeViewController.onComposeExam = { [weak self] exam in
                    exam.save()
                    self?.refreshExams()
                }
            }
        }
    }
    
    private func refreshExams(){
        var exams = Exam.getExams()
        
        //Sorting Exams accordingly
        exams.sort { lhs, rhs in
            if lhs.isComplete && rhs.isComplete {
                // i.
                return lhs.completedDate! < rhs.completedDate!
            } else if !lhs.isComplete && !rhs.isComplete {
                // ii.
                return lhs.createdDate < rhs.createdDate
            } else {
                // iii.
                return !lhs.isComplete && rhs.isComplete
            }
        }
        //Ends here
        
        self.exams = exams
        emptyStateLabel.isHidden = !exams.isEmpty
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
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

extension ExamListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExamCell", for: indexPath) as! ExamCell
        let exam = exams[indexPath.row]
        cell.configure(with: exam)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            exams.remove(at: indexPath.row)
            Exam.save(exams)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ExamListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1.
        tableView.deselectRow(at: indexPath, animated: false)
        // 2.
        let selectedExam = exams[indexPath.row]
        // 3.
        performSegue(withIdentifier: "ComposeExamSegue", sender: selectedExam)
    }
}
