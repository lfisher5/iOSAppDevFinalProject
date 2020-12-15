//
//  ViewController.swift
//  FitnessApp
//
//  Created by Lauren Fisher on 12/1/20.
//

import UIKit

class MyWorkoutTableViewController: UITableViewController {

    var categoryArray = [String]()
    var availableMachineWeightArray : [String] = UserDefaults.standard.object(forKey: "machineWeightArray") as? [String] ?? [String]()

        override func viewDidLoad() {
            print(availableMachineWeightArray)

            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            self.navigationItem.leftBarButtonItem = self.editButtonItem
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                return categoryArray.count
            }
            return 0
        }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            let category = categoryArray[indexPath.row]
            cell.textLabel?.text = category
            cell.textLabel?.font = UIFont(name: "Menlo-Bold", size: 20.0)
            cell.textLabel?.textColor = UIColor(red: 35/255.0, green: 171/255.0, blue: 175/255.0, alpha: 1)
            
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                categoryArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let category = categoryArray.remove(at: sourceIndexPath.row)
            categoryArray.insert(category, at: destinationIndexPath.row)
            tableView.reloadData()
        }

        
        @IBAction func addBarButtonPressed(_ sender: UIBarButtonItem) {
            var alertTextField = UITextField()
            let alert = UIAlertController(title: "Create New Category", message: "", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.placeholder = "Name of Workout"
                alertTextField = textField
            }
            
            let action = UIAlertAction(title: "Create Workout", style: .default) { (alertAction) in
                let text = alertTextField.text!
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd"
                print(dateFormatter.string(from: date))
                self.categoryArray.append(text + "   " + dateFormatter.string(from: date))
                self.tableView.reloadData()
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let identifier = segue.identifier, identifier == "ShowMachinesSegue"  {
                
                guard let workoutTableVC = segue.destination as? WorkoutMachineTableViewController else {
                    return
                }
            
                guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
                    return
                }
                
                let category = categoryArray[selectedIndexPath.row]
                workoutTableVC.category = category
            }
        }
    
    

}

