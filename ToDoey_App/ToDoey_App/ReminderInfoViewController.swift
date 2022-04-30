//
//  ReminderViewController.swift
//  ToDoey_App
//
//  Created by Jonathan Facinelli on 4/27/22.
//

import UIKit

class ReminderInfoViewController: UIViewController {

    @IBOutlet weak var reminderTitle: UINavigationItem!
    @IBOutlet weak var reminderDate: UILabel!
    @IBOutlet weak var reminderInfo: UILabel!
    var reminder = ""
    var reminderDetails = ""
    var reminderDueDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminderTitle.title = reminder
        reminderInfo.text = reminderDetails
        reminderDate.text = reminderDueDate
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

