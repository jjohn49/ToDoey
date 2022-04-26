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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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