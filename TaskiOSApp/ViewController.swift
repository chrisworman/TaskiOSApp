//
//  ViewController.swift
//  TaskiOSApp
//
//  Created by Chris Worman on 2017-10-12.
//  Copyright © 2017 Chris Worman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let taskListNames = ["List 1", "List 2"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(taskListNames.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "taskListCell")
        cell.textLabel?.text = taskListNames[indexPath.row]
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
        
        // get a reference to the second view controller
        //let secondViewController = segue.destination as! SecondViewController
        
        // set a variable in the second view controller with the data to pass
        //secondViewController.receivedData = "hello"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

