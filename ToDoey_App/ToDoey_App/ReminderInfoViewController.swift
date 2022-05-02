//
//  ReminderViewController.swift
//  ToDoey_App
//
//  Created by Jonathan Facinelli on 4/27/22.
//

import UIKit

class ReminderInfoViewController: UIViewController {

    @IBOutlet weak var reminderInfo: UITextView!
    @IBOutlet weak var reminderDate: UILabel!
    @IBOutlet weak var reminderTitle: UINavigationItem!
    var reminder = ""
    var reminderDetails = ""
    var reminderDueDate = ""
//    var dictionary: [String:[String]] = [:]
//
//    init(reminder: String, dictionary: [String:[String]]) {
//        self.reminder = reminder
//        self.dictionary = dictionary
//
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        reminderTitle.title = reminder
        reminderInfo.text = reminderDetails
        reminderDate.text = reminderDueDate
        
        hideKeyboard()
    }
    
    func hideKeyboard(){
        self.view.addGestureRecognizer(self.gestureToHidkeKeyboard())
        self.navigationController?.navigationBar.addGestureRecognizer(self.gestureToHidkeKeyboard())
        
    }
    
    //create a gesture so when you tap off the UITextField the keyboard goes away
    private func gestureToHidkeKeyboard() -> UIGestureRecognizer{
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
                tap.cancelsTouchesInView = false
                return tap
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

