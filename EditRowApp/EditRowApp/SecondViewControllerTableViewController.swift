//
//  SecondViewControllerTableViewController.swift
//  EditRowApp
//
//  Created by Jonathan Kearns on 10/6/22.
//

import UIKit

class SecondViewControllerTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellID = "cellID"
    let episodeArray = ["Episode 1", "Episode 2","Episode 3", "Episode 4","Episode 5", "Episode 6","Episode 7", "Episode 8","Episode 9", "Episode 10"]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    

    
    //    -------------- TABLEVIEW FUNCTIONS ------------
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return episodeArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
            if (cell == nil) {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellID)
            }
            cell?.textLabel?.text = episodeArray[indexPath.row]
            return cell!
        }

      
   

}
