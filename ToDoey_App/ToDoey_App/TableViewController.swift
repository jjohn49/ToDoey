//
//  TableViewController.swift
//  ToDoey_App
//
//  Created by Jonathan Facinelli on 4/25/22.
//

import UIKit

class TableViewController: UITableViewController {
    
    var data = [String]()
    var newReminder: String = ""
    var newReminderDetail: String = ""
    var newReminderDueDate:String = ""
    var reminderInfo: [String:[String]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        //sets bckground color of the view to black
        
        data = [String]()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath)

        cell.textLabel?.text = data[indexPath.row]
        //this sets the background color of eavh cell
        cell.backgroundColor = UIColor.blue //find the light blue shade RGB values
        //Makes the cells have rounded corners
        cell.layer.cornerRadius = 8

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        let reminderDetailVC = segue.source as! ReminderDetailViewController
        //gets the reminder title
        newReminder = reminderDetailVC.reminder
        //gets the details for the reminder
        newReminderDetail = reminderDetailVC.reminderDetail
        //gets the due date for the reminder
        newReminderDueDate = reminderDetailVC.reminderDueDate
        //creates a String array to act as the value in reminder info
        var detailsArray: [String] = []
        // adds the details to the value array
        detailsArray.append(newReminderDetail)
        //adds the due date to the value array
        detailsArray.append(newReminderDueDate)
        
        reminderInfo.updateValue(detailsArray, forKey: newReminder)
        
        //Checks if the reminder is empty
        //if it is empty it will add to data
        if newReminder != ""{
            data.append(newReminder)
            tableView.reloadData()
        }
    }
    
    //Needed inorder for the cancel button in Reminder Detail View
    //to go to the TableView 
    @IBAction func cancel(segue:UIStoryboardSegue){
        
    }

    @IBAction func startEditing(_ sender: Any) {
        isEditing = !isEditing
    }
    
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */


    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = data[sourceIndexPath.row]
        data.remove(at: sourceIndexPath.row)
        data.insert(itemToMove, at: destinationIndexPath.row)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
