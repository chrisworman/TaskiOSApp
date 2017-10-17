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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(lists.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "taskListCell")
        cell.textLabel?.text = lists[indexPath.row].name
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return(cell)
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Segue to the second view controller
        self.performSegue(withIdentifier: "taskListDetailSegue", sender: self)
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskListDetailSegue" {
            let taskListDetailViewController = segue.destination as! TasksViewController
            taskListDetailViewController.taskListId = 666
        }
    }
    
    @IBAction func showNewTaskListAlert(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Task List", message: "", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Create List", style: .default) { (_) in
            //let taskListName = alertController.textFields?[0].text
            // TODO: create and save a new list
        }
        
        // the cancel action does nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        // add the text field to the alert
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter a name for the list"
        }
        
        // add the actions to the alert
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        do {
            try ListApi.shared().get(completion: {(result: [List]) in
                self.lists = result
                DispatchQueue.main.async() {
                    self.listsTableView?.reloadData()
                }
            })
        } catch {
            print("Error info: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

