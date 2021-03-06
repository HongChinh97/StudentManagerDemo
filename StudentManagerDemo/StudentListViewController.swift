//
//  ViewController.swift
//  StudentManagerDemo
//
//  Created by admin on 11/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData

class StudentListViewController: UITableViewController {
    
    var listOfStudent: [PersonEntity]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfStudent = (try? AppDelegate.context.fetch(PersonEntity.fetchRequest())) as [PersonEntity]?
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listOfStudent?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = listOfStudent![indexPath.row].name
        cell.detailTextLabel?.text = listOfStudent![indexPath.row].phone
        
        return cell
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "showDetails":
            let vc = segue.destination as? StudentDetailsVC
            if let row = tableView.indexPathForSelectedRow?.row {
                vc?.student = listOfStudent?[row]
            }
        default:
            return
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let deleteStudent = listOfStudent!.remove(at: indexPath.row)
            AppDelegate.context.delete(deleteStudent)
            
            AppDelegate.saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
}

