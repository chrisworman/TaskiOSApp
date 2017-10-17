//
//  TaskListDetailViewController.swift
//  TaskiOSApp
//
//  Created by Chris Worman on 2017-10-13.
//  Copyright © 2017 Chris Worman. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newTaskButton: UIBarButtonItem!
    @IBOutlet weak var tasksTableView: UITableView!
    
    var tasks: [Task] = []
    var list: List = List(id: 0, name: "", date_created: "", date_modified: "")
    
    // Returns how many Tasks are available when the table view wants to know
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(tasks.count)
    }
    
    // Returns the table view cell for the "Task" at the specified index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "taskCell")
        cell.textLabel?.text = tasks[indexPath.row].text
        cell.accessoryType = UITableViewCellAccessoryType.checkmark
        return(cell)
    }
    
    // Show the "new task" alert in response to a button press in the UI
    @IBAction func showNewTaskAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "New Task", message: "", preferredStyle: .alert)
        
        // the confirm action gets the task text
        let confirmAction = UIAlertAction(title: "Add Task", style: .default) { (_) in
            //let taskText = alertController.textFields?[0].text
            // TODO: create a new task and save it
        }
        
        // the cancel action does nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        // add the text field to the alert
        alertController.addTextField { (textField) in
            textField.placeholder = ""
        }
        
        //adding the action to dialogbox
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
