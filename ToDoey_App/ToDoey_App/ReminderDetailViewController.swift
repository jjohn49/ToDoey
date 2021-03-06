//
//  ReminderDetailViewController.swift
//  ToDoey_App
//
//  Created by Jonathan Facinelli on 4/25/22.
//

import UIKit

class ReminderDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    

    @IBOutlet weak var reminderDetails: UITextField!
    //reminder title
    var reminder: String = ""
    
    @IBOutlet weak var reminderDetailBox: UITextField!
    //reminder details
    var reminderDetail: String = ""
    
    @IBOutlet weak var colorPicker: UIPickerView!
    var colorOfReminder:String = ""
    let colorsToChoose: [String] = ["Color", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
    
    //Used to send the due date over the segue
    var reminderDueDate:String = ""
    
    //date that the reminder was added
    //going to use this to calculate how far
    //the progress bar should be
    var dateAssigned:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorPicker.delegate = self
        colorPicker.dataSource = self
        hideKeyboard()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorsToChoose[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorsToChoose.count
    }
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
      
    }

    @IBAction func done(segue:UIStoryboardSegue) {
         
    }
    
    //sets up the function below
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue"{
            reminder = reminderDetails.text!
            colorOfReminder = colorsToChoose[colorPicker.selectedRow(inComponent: 0)]
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
        
        dateAssigned = dueDateFormat.string(from:Date())
       
        //print("Reminder due date is " + reminderDueDate)
        
        //this sets the text of the label
        //dateLabel.text=reminderDueDate
    }
    
    //this is a test label ablove to show that the Date Picker properly works
    @IBOutlet weak var dateLabel: UILabel!
}
