//
//  TableViewController.swift
//  ExtensionApp
//
//  Created by Bletty Jans on 22/03/17.
//  Copyright © 2017 cs2680. All rights reserved.
//

import Foundation
import UIKit
import WatchConnectivity

class TableViewcontroller: UITableViewController, WCSessionDelegate{

var toDoItems: Array<String>?
    
    override func viewDidLoad() {
        
        self.toDoItems = ["Fold Laundry", "Clean Kitchen", "Call Joe"]
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TableViewcontroller.addItem))
        
        self.navigationItem.rightBarButtonItem = addButton
        self.saveWatchUserInfo()

    }
    
    func addItem()
    
    {
        self.toDoItems?.append("New Item")
        self.tableView .reloadData()
        self.saveWatchUserInfo()
    
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoItems?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ToDoCell")
        
        cell?.textLabel?.text = self.toDoItems![indexPath.row]
        
        cell?.accessoryType = .checkmark
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let itemToMove = toDoItems![sourceIndexPath.row]
        toDoItems?.remove(at: sourceIndexPath.row)
        toDoItems?.insert(itemToMove, at: sourceIndexPath.row)
        
        self.saveWatchUserInfo()
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        toDoItems?.remove(at: indexPath.row)
        
        //self.tableView .reloadData()
        
       // self.tableView .reloadRows(at: <#T##[IndexPath]#>, with: <#T##UITableViewRowAnimation#>)
       // self.tableView .reloadRows(at: <#T##[IndexPath]#>, with: <#T##UITableViewRowAnimation#>)
        
        self.tableView .deleteRows(at: [indexPath], with: .fade)
        self.saveWatchUserInfo()
    }
    
    
    func saveWatchUserInfo()  {
        
        if WCSession.isSupported()
        
        {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
            
            if session.isPaired
            {
                if session.isWatchAppInstalled
                
                {
                    let toDoDict = ["Items": toDoItems]
                    
                    do
                    {
                        try session.updateApplicationContext(toDoDict)
                    }
                    
                    catch
                    {
                        
                        print(error)
                    }
                }
            }
        }
    }
    
    
}
