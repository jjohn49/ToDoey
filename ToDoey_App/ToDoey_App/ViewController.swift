//
//  ViewController.swift
//  ToDoey_App
//
//  Created by John Johnston on 4/24/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableViewData = Array(repeating: "Item", count: 5)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets bckground color of the view to black
        self.view.backgroundColor = UIColor.black
        tableView.register(UITableViewCell.self,
                               forCellReuseIdentifier: "TableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.tableViewData[indexPath.row]
            
        return cell
    }

//    func tableView(_ tableView: UITableView,
//                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",
//                                                     for: indexPath)
//            cell.textLabel?.text = self.tableViewData[indexPath.row]
//            return cell
//    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableViewData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addRow(_ sender: UIButton) {
        self.tableViewData.append("Item")
//        self.tableView.reloadData()
        self.tableView.performBatchUpdates({
            self.tableView.insertRows(at: [IndexPath(row: self.tableViewData.count - 1,
                                                     section: 0)],
                                      with: .automatic)
        }, completion: nil)
    }
}

