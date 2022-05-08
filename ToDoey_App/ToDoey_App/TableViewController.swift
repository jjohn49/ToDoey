//
//  TableViewController.swift
//  ToDoey_App
//
//  Created by Jonathan Facinelli on 4/25/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell{
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDueDate: UILabel!
    @IBOutlet weak var cellDaysLeft: UILabel!
    @IBOutlet weak var cellBar: UIProgressView!
}

class TableViewController: UITableViewController {
    
    var data = [String]()
    var newReminder: String = ""
    var newReminderDetail: String = ""
    var newReminderDueDate: String = ""
    var selectedReminder: String = ""
    var reminderInfo: [String:[String]] = [:]
    var appData:NSMutableDictionary = [:]
    var indexOfCell: String = ""
    var timeReminderWasAssigned:String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
    
        createPlist()
        //gets the reminders from when you closed the app
        //sets them to a NSDictionary called appData
        getRemindersFromPlistToAppData()
        
        data = [String]()
        
        reminderInfo = appData as! Dictionary<String,Array<String>>
        //print("start of reminder info xxxxxxxxxxxxxxxx")
        print(reminderInfo)
        
        //getRemindersInOrderOfDueDate()
        
        
        /*for x in reminderInfo.keys{
            data.append(x)
        }*/
        if reminderInfo.keys.count > 0{
            getOrderOfReminder()
        }
        
        DispatchQueue.main.async {
            //self.getOrderOfReminder()
            self.tableView.reloadData()
        }
        
        //changes the timer for each cell after every minute
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+10.0){
            self.tableView.reloadData()
        }
        
        
        
        /*let path = Bundle.main.path(forResource: "StorageLocation", ofType: "plist")!
        let dict = NSDictionary(contentsOfFile: path)
        
        let rem = dict!.object(forKey: "ekdnl") as! [String]
        
        print(rem[0])*/
    
        //sets bckground color of the view to black
        //print("THIS WORKED XXXXXXXXXXXXXXX")
        //data = [String]()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //creates the plist in the documents folder
    func createPlist(){
        let filem = FileManager.default
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let p = docDir.appending("/StorageLocation.plist")
        
        if(!filem.fileExists(atPath: p)){
            let success:Bool = appData.write(toFile: p, atomically: true)
            if success{
                print("File Created")
            }else{
                print("File not created")
            }
        }else{
            print("File Exists")
        }
    }
    
    
    
    
    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as! CustomTableViewCell
        
        //et cellRow = indexPath.row
        

        cell.cellTitle.text = data[indexPath.row]
        if reminderInfo[cell.cellTitle.text!]![1] != ""{
            cell.cellDueDate.text = "Due on: " + reminderInfo[cell.cellTitle.text!]![1]
            cell.cellDaysLeft.text = getDateDifference(dueDate: reminderInfo[cell.cellTitle.text!]![1])
            cell.cellBar.setProgress(getValForCellBar(dueDate: reminderInfo[cell.cellTitle.text!]![1], dateAdded: reminderInfo[cell.cellTitle.text!]![2]), animated: true)
            if getValForCellBar(dueDate: reminderInfo[cell.cellTitle.text!]![1], dateAdded: reminderInfo[cell.cellTitle.text!]![2]) > Float(1){
                cell.cellBar.progressTintColor = .red
            }
            
            //this set the value in the array for each reminder to the order
            //of what it should be in.  IT DOESN'T WORK
            //keep here in case I need it some other time
            /*
            if reminderInfo[cell.cellTitle.text!]?.count==3{
                reminderInfo[cell.cellTitle.text!]![2] = String(indexPath.row)
            }else{
                reminderInfo[cell.cellTitle.text!]?.append(String(indexPath.row))
                            print(reminderInfo)
            }
             */
            
        }else{
            cell.cellDueDate.text = "NO DUE DATE"
            cell.cellDaysLeft.text = "-----------"
        }
       
        //this sets the background color of eavh cell
        //cell.backgroundColor = UIColor.blue //find the light blue shade RGB values
        //Makes the cells have rounded corners
        cell.layer.cornerRadius = 20

        return cell
    }
    
    func getValForCellBar(dueDate:String, dateAdded:String) -> Float{
        let format = DateFormatter()
        format.dateStyle = DateFormatter.Style.short
        format.timeStyle = DateFormatter.Style.short
        
        let dueDateAsDate = format.date(from: dueDate)
        let dateAddedAsDate = format.date(from: dateAdded)!
        
        let totalTimeInterval = dueDateAsDate!.timeIntervalSince(dateAddedAsDate)
        let intervalFromDateAddedToNow = Double(-1)*(dateAddedAsDate.timeIntervalSinceNow)
        
        //print("Total time Interval is " + String(totalTimeInterval))
        //print("Interval from when the reminder was added is " + String(intervalFromDateAddedToNow))
        
        //print("The value of the progres bar is now " + String(Float(intervalFromDateAddedToNow/totalTimeInterval)))
        
        return Float(intervalFromDateAddedToNow/totalTimeInterval)
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let del = data[indexPath.row]
            //print(del)
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            deleteFromPlist(key: del)
        }
    }
    
    func deleteFromPlist(key:String){
        let path = getPath()
        if FileManager.default.fileExists(atPath: path){
            let data = NSMutableDictionary(contentsOfFile: path) ?? ["":[""]]
            data.removeObject(forKey: key)
            data.write(toFile: path, atomically: true)
        }
    }
    
    //This is for calculating what should be higher on the list
    func getDateDifference(dueDate:String) -> TimeInterval{
        let format = DateFormatter()
        format.dateStyle = DateFormatter.Style.short
        format.timeStyle = DateFormatter.Style.short
        //print(dueDate)
        
        let d2 = format.date(from: dueDate)
        let now = format.date(from: format.string(from: Date()))!
        //print(d2)
        print(now)
        
        if d2 == nil {
            return TimeInterval.infinity
        }
        
        let diffsecs = d2!.timeIntervalSince(now)
        
        //print(diffsecs)
        return diffsecs
    }
    
    //This is for calculating the difference between now and when
    //The reminder is due
    func getDateDifference(dueDate:String) -> String{
        let format = DateFormatter()
        format.dateStyle = DateFormatter.Style.short
        format.timeStyle = DateFormatter.Style.short
        //print(dueDate)
        let d2 = format.date(from: dueDate)
        let now = format.date(from: format.string(from: Date()))!
        //print(d2)
        //print(now)
        let diffsecs = d2!.timeIntervalSince(now)
        
        //print(diffsecs)
        
        return secsToTime(diff: diffsecs)
    }
    
    func secsToTime(diff: TimeInterval) -> String{
        var x = diff
        
        x /= 60
        
        
        
        let mins = String(Int(x.truncatingRemainder(dividingBy: 60)))
        x /= 60
        
        //print("mins is " + mins)
        
        let hours = String(Int(x.truncatingRemainder(dividingBy: 24)))
        x /= 24
        
        //print("hours is " + hours)
        
        let days = String(Int(x))
        
        //print("Days is " + days)
        
        return "D:" + days + " H:" + hours + " M:" + mins + " LEFT TILL DUE"
        
        
        
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        let reminderDetailVC = segue.source as! ReminderDetailViewController
        //gets the reminder title
        newReminder = reminderDetailVC.reminder
        //gets the details for the reminder
        newReminderDetail = reminderDetailVC.reminderDetail
        //gets the due date for the reminder
        newReminderDueDate = reminderDetailVC.reminderDueDate
        
        timeReminderWasAssigned = reminderDetailVC.dateAssigned
        
       
        
        
        //creates a String array to act as the value in reminder info
        var detailsArray:[String] = []
        // adds the details to the value array
        detailsArray.append(newReminderDetail)
        //adds the due date to the value array
        detailsArray.append(newReminderDueDate)
        //adds when the assignment was added
        detailsArray.append(timeReminderWasAssigned)
        
        
        
        
        
        
        //appData = reminderInfo as! NSDictionary
        //print(appData)
        //writePropertyList(plistName: "Data")
        
        //Checks if the reminder is empty
        //if it is not empty it will add to data
        if newReminder != ""{
            data.append(newReminder)
            //print(data)
            tableView.reloadData()
            print(reminderInfo)
            
            reminderInfo.updateValue(detailsArray, forKey: newReminder)
            
            //sends the data to the plist
            let path = self.getPath()
            print(path)
            if FileManager.default.fileExists(atPath: path){
                let data = NSMutableDictionary(contentsOfFile: path) ?? ["":[""]]
                data.addEntries(from: reminderInfo)
                print(reminderInfo)
                data.write(toFile: path, atomically: true)
            }
            
            //getRemindersInOrderOfDueDate()
        }
    }
    
//    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
//        let reminderInfoVC = ReminderInfoViewController(reminderDetails: reminderInfo)
//
//        selectedReminder = data[indexPath.row]
//
//        //Initializes the data from the cell selected
//        reminderInfoVC.title = selectedReminder
//
//        self.navigationController?.pushViewController(reminderInfoVC, animated: true)
//
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "getCellInfo", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Checks if segue used is going to ReminderInfoViewContoller
        if segue.identifier == "getCellInfo"{
            let reminderInfoVC = segue.destination as! ReminderInfoViewController
            let cell = sender as! CustomTableViewCell
            
            let name: String = (cell.cellTitle?.text)! as String
            //Initializes the data from the cell selected
            reminderInfoVC.reminderTitle.title = name
            print((cell.cellTitle.text)! as String)
            reminderInfoVC.reminderDetails = (reminderInfo[name]?[0])!
            reminderInfoVC.reminderDueDate = (reminderInfo[name]?[1])!
            
            // if we get the name of the cell put that variable name in the place holder area
//            reminderInfoVC.reminder = (name of cell)
//            reminderInfoVC.reminderDetails = reminderInfo[(name of cell)][0]
//            reminderInfoVC.reminderDueDate = reminderInfo[(name of cell)][1]
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
    

    
    //Override to support rearranging the table view.
    


    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = data[sourceIndexPath.row]
        data.remove(at: sourceIndexPath.row)
        data.insert(itemToMove, at: destinationIndexPath.row)
        
    }
    
    //gets path of the plist
    func getPath() -> String {
        let plistFileName = "StorageLocation.plist"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentPath = paths[0] as NSString
        let plistPath = documentPath.appendingPathComponent(plistFileName)
        print(plistPath)
        return plistPath
    }
    
    //gets the reminders from the plist
    //sets it to appData
    func getRemindersFromPlistToAppData() {
        let path = self.getPath()
        if FileManager.default.fileExists(atPath: path){
            appData = NSMutableDictionary(contentsOfFile: path) ?? ["":[""]]
        }
    }
    
    
    //gets the reminders in order of how soon they are due
    //anything without a due date is randomly put at the bottom
    func getOrderOfReminder(){
        var temp = Array(reminderInfo.keys)
        
        var removed : [String] = []
        
        for x in temp where temp.count>1{
            //print("X is changing to " + x)
            //print(temp)
            var xDueDate: String = ""
            var earliest : String = ""
            if let xArr = reminderInfo[x]{
                xDueDate = xArr[1]
                earliest = x
            }
            if xDueDate == ""{
                removed.append(x)
                //print("Apended " + x + " to removed")
                if let index = temp.firstIndex(of: x){
                    temp.remove(at: index)
                }
                continue
            }
            for y in temp where y != x{
                //print(temp)
                //print("X is " + x)
                //print("Y is " + y)
                var yDueDate: String = ""
                if let yArr = reminderInfo[y]{
                    yDueDate = yArr[1]
                }
                if yDueDate == ""{
                    removed.append(y)
                    //print("Apended " + y + " to removed")
                    if let index = temp.firstIndex(of: y){
                        temp.remove(at: index)
                    }
                    continue
                }
                
                if getDateDifference(dueDate: yDueDate).isLess(than: getDateDifference(dueDate: xDueDate)){
                    //print("Earliest is changing from " + earliest + " To " + y)
                    earliest = y
                }
            }
            data.append(earliest)
            //print("Apended " + earliest + " to data")
            if let index = temp.firstIndex(of: earliest){
                temp.remove(at: index)
            }
        }
        let last = temp.removeFirst()
        
        data.append(last)
        
        for x in removed{
            data.append(x)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //gets the url of the local storage
    /*var plistURL: URL {
        let documentDirectoryURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        print(documentDirectoryURL.appendingPathComponent("StorageLocation.plist"))
        return documentDirectoryURL.appendingPathComponent("StorageLocation.plist")
    }
    //saves the reminder on your phone for local storage
    func saveReminder(_ plist: Any)throws{
        let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try plistData.write(to: plistURL)
    }
    //suppose to load the reminders from locals torage
    func loadreminder() throws -> [String:String]
    {
        let data = try Data(contentsOf: plistURL)
        //print(data)
        //this isn't working
        guard let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String:String] else {
            return [:]
        }
        return plist
    }*/
    //this works
    
    
    
    
}
