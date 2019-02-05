//
//  SecondViewController.swift
//  ExtensionApp
//
//  Created by Bletty Jans on 22/03/17.
//  Copyright © 2017 cs2680. All rights reserved.
//

import Foundation
import UIKit



class TableViewcontroller: UITableViewController {
    
    var toDoItems: Array<String>?
    
    override func viewDidLoad() {
        
        self.toDoItems = ["Feed Cat", "Clean Washroom", "Call Jans"]
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoItems?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ToDoCell")
        
        cell?.textLabel?.text = self.toDoItems![indexPath.row]
        
        return cell!
    }
    
    
}
