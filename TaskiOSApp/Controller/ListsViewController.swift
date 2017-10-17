//
//  ViewController.swift
//  TaskiOSApp
//
//  Created by Chris Worman on 2017-10-12.
//  Copyright © 2017 Chris Worman. All rights reserved.
//

import UIKit

class ListsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newTaskListButton: UIBarButtonItem!
    @IBOutlet weak var listsTableView: UITableView!
    
    var lists: [List] = []
    
    // Returns how many Lists are available when the table view wants to know
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(lists.count)
    }
    
    // Returns the table view cell for the "List" at the specified index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "taskListCell")
        cell.textLabel?.text = lists[indexPath.row].name
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return(cell)
    }
    
    // Table view cell tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Segue to the second view controller
        self.performSegue(withIdentifier: "tasksViewControllerSegue", sender: self)
    }
    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tasksViewControllerSegue" {
            if let indexPath = listsTableView.indexPathForSelectedRow {
                let taskListDetailViewController = segue.destination as! TasksViewController
                taskListDetailViewController.list = lists[indexPath.row]
            }
        }
    }
    
    // Show the "new list" alert in response to a button press in the UI
    @IBAction func showNewTaskListAlert(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Task List", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter a list name"
        }
        
        // When the user confirms, get the name and create a new list via the api
        let confirmAction = UIAlertAction(title: "Create List", style: .default) { (_) in
            let newListName = alertController.textFields?[0].text
            let newList = List(id: 0, name: newListName!, date_created: "", date_modified: "")
            do {
                try ListApi.shared().create(newList: newList, completion: {(newList: List) in
                    self.addListToUI(newList: newList)
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
    
    // Reload the lists from the api and update the UI
    private func reloadLists() {
        do {
            try ListApi.shared().getAll(completion: {(result: [List]) in
                self.lists = result
                DispatchQueue.main.async() {
                    self.listsTableView?.reloadData()
                }
            })
        } catch {
            print("Error info: \(error)")
        }
    }
    
    // Add the specified List model to the UI
    private func addListToUI(newList: List) {
        lists.append(newList)
        DispatchQueue.main.async() {
            self.listsTableView?.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadLists()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

