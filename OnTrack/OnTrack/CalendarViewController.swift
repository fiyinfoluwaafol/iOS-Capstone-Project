//
//  CalendarViewController.swift
//  OnTrack
//
//  Created by Fiyinfoluwa Afolayan on 11/13/23.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarContainerView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var tasks: [Task] = []
    
    private var selectedTasks: [Task] = []
    private var calendarView: UICalendarView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 1.
        tableView.dataSource = self
        // 2.
        tableView.tableHeaderView = UIView()
        // 3.
        setContentScrollView(tableView)
        
        // 1.
        self.calendarView = UICalendarView()
        // 2.
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        // 3.
        calendarContainerView.addSubview(calendarView)
        // 4.
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
            calendarView.topAnchor.constraint(equalTo: calendarContainerView.topAnchor),
            calendarView.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: calendarContainerView.bottomAnchor)
        ])
        
        // 1.
        calendarView.delegate = self
        // 2.
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        
        // 1.
        tasks = Task.getTasks()
        // 2.
        let todayComponents = Calendar.current.dateComponents([.year, .month, .weekOfMonth, .day], from: Date())
        // 3.
        let todayTasks = filterTasks(for: todayComponents)
        // 4.
        if !todayTasks.isEmpty {
            // i.
            let selection = calendarView.selectionBehavior as? UICalendarSelectionSingleDate
            // ii.
            selection?.setSelected(todayComponents, animated: false)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshTasks()
    }
    
    private func filterTasks(for dateComponents: DateComponents) -> [Task] {
        // 1.
        let calendar = Calendar.current
        // 2.
        guard let date = calendar.date(from: dateComponents) else {
            return []
        }
        // 3.
        let tasksMatchingDate = tasks.filter { task in
            // i.
            return calendar.isDate(task.dueDate, equalTo: date, toGranularity: .day)
        }
        // 4.
        return tasksMatchingDate
    }
    
    private func refreshTasks() {
        // 1.
        tasks = Task.getTasks()
        // 2.
        tasks.sort { lhs, rhs in
            if lhs.isComplete && rhs.isComplete {
                return lhs.completedDate! < rhs.completedDate!
            } else if !lhs.isComplete && !rhs.isComplete {
                return lhs.createdDate < rhs.createdDate
            } else {
                return !lhs.isComplete && rhs.isComplete
            }
        }
        // 3.
        if let selection = calendarView.selectionBehavior as? UICalendarSelectionSingleDate,
            let selectedComponents = selection.selectedDate {

            selectedTasks = filterTasks(for: selectedComponents)
        }
        // 4.
        let taskDueDates = tasks.map(\.dueDate)
        // 5.
        var taskDueDateComponents = taskDueDates.map { dueDate in
            Calendar.current.dateComponents([.year, .month, .weekOfMonth, .day], from: dueDate)
        }
        // 6.
        taskDueDateComponents.removeDuplicates()
        // 7.
        calendarView.reloadDecorations(forDateComponents: taskDueDateComponents, animated: false)
        // 8.
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }

}

extension CalendarViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        // 1.
        let tasksMatchingDate = filterTasks(for: dateComponents)
        // 2.
        let hasUncompletedTask = tasksMatchingDate.contains { task in
            return !task.isComplete
        }
        // 3.
        if !tasksMatchingDate.isEmpty {
            // i.
            let image = UIImage(systemName: hasUncompletedTask ? "circle" : "circle.inset.filled")
            // ii.
            return .image(image, color: .systemBlue, size: .large)
        } else {
            // iii.
            return nil
        }
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {

    // Similar to the `tableView(_:didSelectRowAt:)` delegate method, the Calendar View's `dateSelection(_:didSelectDate:)` delegate method is called whenever a user selects a date on the calendar.
    // 1. Unwrap the optional date components for the selected date.
    // 2. Update selectedTasks by filtering all tasks for the selected date.
    // 3. If there are no tasks associated with the selected date, deselect the date by setting the selection to nil
    // 4. Otherwise, if there are associated tasks for the date, reload the table view of selected tasks.
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        // 1.
        guard let components = dateComponents else { return }
        // 2.
        selectedTasks = filterTasks(for: components)
        // 3.
        if selectedTasks.isEmpty {
            selection.setSelected(nil, animated: true)
        }
        // 4.
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}

extension CalendarViewController: UITableViewDataSource {

    // The number of rows to show based on the number of selected tasks (i.e. tasks associated with the current selected date)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedTasks.count
    }

    // Create and configure a cell for each row of the table view (i.e. each task in the selectedTasks array)
    // 1. Dequeue a Task cell.
    // 2. Get the selected task associated with the current row.
    // 3. Configure the cell with the selected task and add the code to be run when the complete button is tapped...
    //    i. Save the task passed back in the closure.
    //    ii. Refresh the tasks list to reflect the updates with the saved task.
    // 4. Return the configured cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1.
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        // 2.
        let task = selectedTasks[indexPath.row]
        // 3.
        cell.configure(with: task)
        // 4.
        return cell
    }
}

extension Array where Element: Equatable, Element: Hashable {

    // A helper method to remove any duplicate values from an array.
    // 1. Initialize a set with the given array
    //    - Sets guarantee that all values are unique, so any duplicates are removed.
    //    - This method is an array instance method so `self` references the array instance on which the method is being called.
    // 2. Initialize an array from the set to arrive at an array with no duplicate values.
    mutating func removeDuplicates() {
        // 1.
        let set = Set(self)
        // 2.
        self = Array(set)
    }
}
