//
//  ReminderViewController.swift
//  ToDoey_App
//
//  Created by Jonathan Facinelli on 4/27/22.
//

import UIKit

class ReminderInfoViewController: UIViewController {

    @IBOutlet weak var reminderTitle: UILabel!
    @IBOutlet weak var reminderDate: UILabel!
    @IBOutlet weak var reminderInfo: UILabel!
    var titleOfReminder:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = titleOfReminder
        reminderTitle.title = titleOfReminder
        }

    @IBAction func info(segue:UIStoryboardSegue) {
        let TableVC = segue.source as! TableViewController
        //gets the reminder title
        reminderTitle.text = TableVC.newReminder
        //gets the details for the reminder
        reminderInfo.text = TableVC.newReminderDetail
        //gets the due date for the reminder
        reminderDate.text = TableVC.newReminderDueDate
        //creates a String array to act as the value in reminder info
//        var detailsArray: [String] = []
//        // adds the details to the value array
//        detailsArray.append(newReminderDetail)
//        //adds the due date to the value array
//        detailsArray.append(newReminderDueDate)
//
//        reminderInfo.updateValue(detailsArray, forKey: newReminder)
//
//        //Checks if the reminder is empty
//        //if it is empty it will add to data
//        if newReminder != ""{
//            data.append(newReminder)
//            tableView.reloadData()
//        }
    }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

