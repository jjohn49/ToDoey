//
//  ReminderViewController.swift
//  ToDoey_App
//
//  Created by Jonathan Facinelli on 4/27/22.
//

import UIKit

class ReminderInfoViewController: UIViewController {

    var titleOfReminder:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = titleOfReminder
        reminderTitle.title = titleOfReminder
        }

    @IBOutlet weak var reminderTitle: UINavigationItem!
    
    //not done
    @IBAction func title(segue:UIStoryboardSegue){
        let reminderDetailVC = segue.source as! ReminderDetailViewController
        //gets the title of the task
        let titleFromReminder = reminderDetailVC.reminder
        //tries to make the navigation item the title
        titleOfReminder = titleFromReminder
        
        //reminderTitle.title = titleFromReminder
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

