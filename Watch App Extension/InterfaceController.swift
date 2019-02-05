//
//  InterfaceController.swift
//  Watch App Extension
//
//  Created by Bletty Jans on 22/03/17.
//  Copyright © 2017 cs2680. All rights reserved.
//

import WatchKit
import Foundation
import  WatchConnectivity


class InterfaceController: WKInterfaceController,WCSessionDelegate {
    
    @IBOutlet var table: WKInterfaceTable!
    
    
    override func awake(withContext context: Any?) {
      
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        
        if WCSession.isSupported()
        {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
        if let toDoItems = applicationContext["Items"] as? Array<String>
        {
            table.setNumberOfRows(toDoItems.count, withRowType: "TableRow")
            
            for (index, toDoItem) in toDoItems.enumerated()
            {
                if let rowController = table.rowController(at: index) as? ToDoRowController
                {
                    rowController.toDoLabel.setText(toDoItem)          }
            }
        }
    }
   
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?)
    {
    }
    
    
}
