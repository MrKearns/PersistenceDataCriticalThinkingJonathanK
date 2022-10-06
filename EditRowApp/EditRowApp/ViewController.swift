//
//  ViewController.swift
//  EditRowApp
//
//  Created by Jonathan Kearns on 10/4/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    ------------- VARIABLES & CONSTANTS ------------
    
    var podArray = ["one", "two"]
    let cellID = "cellID"
    let sortB = "sortB"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortButton: UIButton!
    
    
    var press = [true, false]
    var buttonLabel = ""
    
    
   
//     ------------- SORT BUTTON FUNCTION ----------
    
    @IBAction func sort(_ sender: UIButton) {
        press[0].toggle()
        if press[0] == true{
            podArray.sort(by: <)
//            tableView.reloadData()
//            buttonLabel = "A-Z"
//            sortButton.setTitle("A to Z", for: .normal)
            
//            UserDefaults.standard.set(sortButton.titleLabel!.text, forKey: "sortB")
//            UserDefaults.standard.set(self.podArray, forKey: "myArray")
            
            
        }
        
        if press[0] == false{
            podArray.sort(by: >)
//            tableView.reloadData()
//            buttonLabel = "Z-A"
//            sortButton.setTitle("Z to A", for: .normal)
            
//            UserDefaults.standard.set(sortButton.titleLabel!.text, forKey: "sortB")
//            UserDefaults.standard.set(self.podArray, forKey: "myArray")
//
        }
//        sortButton.setTitle(buttonLabel, for: .normal)
        
//        UserDefaults.standard.set(sortButton.titleLabel!.text, forKey: "sortB")
        UserDefaults.standard.set(self.podArray, forKey: "myArray")
        tableView.reloadData()
        
    
        
    }
    
    
    
    
//     ------------- ADD PODCAST BUTTON (+) ------------
    
    @IBAction func addPodcastButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add", message: "new podcast", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {(textField) in textField.placeholder = "Podcast Title"})
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
            let savedText = alert.textFields![0] as UITextField
            self.podArray.append(savedText.text ?? "default")
            
            
            if self.press[0] == true{
                self.podArray.sort(by: <)
            }
            
            if self.press[0] == false{
                self.podArray.sort(by: >)
                
            }
            
            self.tableView.reloadData()

        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
//    ------------- VIEW DID LOAD -----------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        setButtonTitle()
        loadArray()
//        let title = UserDefaults.standard.string(forKey: sortB)
//        sortButton.setTitle(title, for: .normal)
    
    }
    
    
    //  -------------- PREPARE FOR SEGUE --------------
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondController = segue.destination as! SecondViewControllerTableViewController
    }
    
    
//    -------------- TABLEVIEW FUNCTIONS ------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = podArray[indexPath.row]
        return cell!
    }
    
    
//    -------------- SELECT ROW FUNCTION -------------
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedItem = podArray[indexPath.row]
        
        performSegue(withIdentifier: "segue", sender: self)

    }
    
    
    
//     ------------- ADD PODCAST ALERT ----------------
    
    func displayAlert(location:Int) {
        let alert = UIAlertController(title: "Add", message: "new podcast", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {(textField) in textField.placeholder = "Podcast Title"})
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
            let savedText = alert.textFields![0] as UITextField
            self.podArray.insert(savedText.text ?? "default", at: location)
            self.tableView.reloadData()
            UserDefaults.standard.set(self.podArray, forKey: "myArray")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
//    ------------- TRAILING SWIPE ACTION (DELETE) ---------------
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (contextualAction, view, boolValue) in
            self.podArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            UserDefaults.standard.set(self.podArray, forKey: "myArray")
        }
        
            let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
            return swipeActions
            
        }
    
    
//    ------------- LEADING SWIPE ACTION (ADD) -----------------
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title: "Add") {
            (contextualAction, view, boolValue) in
            self.displayAlert(location: indexPath.row)
            UserDefaults.standard.set(self.podArray, forKey: "myArray")
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [addAction])
        return swipeActions
    }
    
    
    
//    ------------- LOAD ARRAY & SET BUTTON FUNCTIONS --------------
    
    
    func loadArray(){
        podArray = UserDefaults.standard.object(forKey: "myArray") as? [String] ?? []
    }
    
    
    func setButtonTitle(){
        let title = UserDefaults.standard.string(forKey: sortB)
        sortButton.setTitle(title, for: .normal)
    }


}

