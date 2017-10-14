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
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "TaskListCell")
        cell.textLabel?.text = taskListNames[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return(cell)
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

