//
//  ReminderDetailViewController.swift
//  ToDoey_App
//
//  Created by Jonathan Facinelli on 4/25/22.
//

import UIKit

class ReminderDetailViewController: UIViewController {

    @IBOutlet weak var reminderDetails: UITextField!
    //reminder title
    var reminder: String = ""
    
    @IBOutlet weak var reminderDetailBox: UITextView!
    //reminder details
    var reminderDetail: String = ""
    
    //Used to send the due date over the segue
    var reminderDueDate:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        reminderDetailBox.layer.borderWidth = 0.5
        reminderDetailBox.layer.borderColor = borderColor.cgColor
        reminderDetailBox.layer.cornerRadius = 5.0
    }
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
      
    }

    @IBAction func done(segue:UIStoryboardSegue) {
         
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue"{
            reminder = reminderDetails.text!
        }
        else if segue.identifier == "cancelSegue"{
            reminder = ""
        }
        //sets the reminderDetail to the text entered in the text box
        reminderDetail = reminderDetailBox.text!
    }
    //this is the date picker object
    @IBOutlet weak var dueDate: UIDatePicker!
    
    //this sets the format of the date picker and makes the info to the string
    //Need to send the string to TableView
    //Need to make it centered
    @IBAction func dueDateChanger(_ sender: Any) {
        let dueDateFormat = DateFormatter()
        
        dueDateFormat.dateStyle = DateFormatter.Style.short
        dueDateFormat.timeStyle = DateFormatter.Style.short
        
        reminderDueDate = dueDateFormat.string(from: dueDate.date)
        
        
        //this sets the text of the label
        dateLabel.text = reminderDueDate
    }
    
    //this is a test label ablove to show that the Date Picker properly works
    @IBOutlet weak var dateLabel: UILabel!
}
