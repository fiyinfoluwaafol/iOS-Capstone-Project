//
//  HomeworkListViewController.swift
//  OnTrack
//
//  Created by Fiyinfoluwa Afolayan on 11/7/23.
//

import UIKit

class HomeworkListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyHWLabel: UILabel!
    
    var homeworks = [Homework]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableHeaderView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        refreshHomeworks()
    }
    
    @IBAction func didTapNewHomeworkButton(_ sender: Any) {
        performSegue(withIdentifier: "ComposeHomeworkSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ComposeHomeworkSegue" {
            if let composeNavController = segue.destination as? UINavigationController,
               let homeworkComposeViewController = composeNavController.topViewController as? HomeworkComposeViewController {
                homeworkComposeViewController.homeworkToEdit = sender as? Homework
                homeworkComposeViewController.onComposeHomework = { [weak self] homework in
                    homework.save()
                    self?.refreshHomeworks()
                }
            }
        }
    }
    
    private func refreshHomeworks() {
        // 1.
        var homeworks = Homework.getTasks()
        // 2.
        homeworks.sort { lhs, rhs in
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
        // 3.
        self.homeworks = homeworks
        // 4.
        emptyHWLabel.isHidden = !homeworks.isEmpty
        // 5.
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

extension HomeworkListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeworkCell", for: indexPath) as! HomeworkCell
        let homework = homeworks[indexPath.row]
        cell.configure(with: homework, onCompleteButtonTapped: { [weak self] homework in
            homework.save()
            self?.refreshHomeworks()
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            homeworks.remove(at: indexPath.row)
            Homework.save(homeworks)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension HomeworkListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1.
        tableView.deselectRow(at: indexPath, animated: false)
        // 2.
        let selectedHomework = homeworks[indexPath.row]
        // 3.
        performSegue(withIdentifier: "ComposeHomeworkSegue", sender: selectedHomework)
    }
}
