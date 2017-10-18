//
//  TaskListDetailViewController.swift
//  TaskiOSApp
//
//  Created by Chris Worman on 2017-10-13.
//  Copyright © 2017 Chris Worman. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var deleteTaskButton: UIButton!
    @IBOutlet weak var newTaskButton: UIBarButtonItem!
    @IBOutlet weak var tasksTableView: UITableView!
    
    private let taskCellDoneButtonTag: Int = 10
    
    var tasks: [Task] = []
    var list: List = List(id: 0, name: "", date_created: "", date_modified: "")
    
    // Returns how many Tasks are available when the table view wants to know
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(tasks.count)
    }
    
    // Returns the table view cell for the "Task" at the specified index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tasksTableView.dequeueReusableCell(withIdentifier: "taskCell")!
        cell.textLabel?.text = task.text
        
        // Set the tag of the done button to be the id of the task
        if let doneButton = cell.viewWithTag(taskCellDoneButtonTag) as? UIButton {
            doneButton.tag = task.id
        }
        
        return(cell)
    }
    
    // Respond to a task cell checkmark button press: delete the task
    @IBAction func deleteTask(_ sender: UIButton) {
        let taskId = sender.tag
        do {
            try TaskApi.shared().delete(taskId: taskId, completion: {() in
                self.deleteTaskFromUI(taskId: taskId)
            })
        } catch {
            print("Error info: \(error)")
        }
    }
    
    // Show the "new task" alert in response to a button press in the UI
    @IBAction func showNewTaskAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "New Task", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = ""
        }
        
        // When the user confirms, get the text and create a new task via the api
        let confirmAction = UIAlertAction(title: "Add Task", style: .default) { (_) in
            let text = alertController.textFields?[0].text
            let newTask = Task(id: 0, list_id: self.list.id, text: text!, date_created: "", date_modified: "")
            do {
                try TaskApi.shared().create(newTask: newTask, completion: {(newTask: Task) in
                    self.addTaskToUI(newTask: newTask)
                })
            } catch {
                print("Error info: \(error)")
            }
        }
        
        // The cancel action does nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Reload the tasks from the api and update the UI
    private func reloadTasks() {
        do {
            try TaskApi.shared().getByListId(listId: list.id, completion: {(result: [Task]) in
                self.tasks = result
                DispatchQueue.main.async() {
                    self.tasksTableView?.reloadData()
                }
            })
        } catch {
            print("Error info: \(error)")
        }
    }
    
    // Add the specified task to the UI
    private func addTaskToUI(newTask: Task) {
        tasks.append(newTask)
        DispatchQueue.main.async() {
            self.tasksTableView?.reloadData()
        }
    }
    
    // Delete the specified task from the UI
    private func deleteTaskFromUI(taskId : Int) {
        let taskIndex = tasks.index{ $0.id == taskId }
        if taskIndex != nil {
            tasks.remove(at: taskIndex!)
            reloadTasks()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = list.name
        reloadTasks()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
