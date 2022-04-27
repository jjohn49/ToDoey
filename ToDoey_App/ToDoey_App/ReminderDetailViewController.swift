//
//  ReminderDetailViewController.swift
//  ToDoey_App
//
//  Created by Jonathan Facinelli on 4/25/22.
//

import UIKit

class ReminderDetailViewController: UIViewController {
    
    @IBOutlet weak var reminderDetails: UITextField!
    var reminder: String = ""
    
    @IBOutlet weak var reminderDetailBox: UITextView!
    var reminderDetail: String = ""
    
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
        if segue.identifier == "doneSegue" && reminderDetails.text != "" {
            reminder = reminderDetails.text!
        }
    }
    
}
