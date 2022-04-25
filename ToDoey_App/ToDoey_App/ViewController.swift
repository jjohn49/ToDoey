//
//  ViewController.swift
//  ToDoey_App
//
//  Created by John Johnston on 4/24/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var tableViewData = Array(repeating: "Item", count: 5)
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self,
                               forCellReuseIdentifier: "TableViewCell")
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",
                                                     for: indexPath)
            cell.textLabel?.text = self.tableViewData[indexPath.row]
            return cell
    }
    @IBAction func addRow(_ sender: UIButton) {
        self.tableViewData.append("Item")
        self.tableView.reloadData()
    }
}



