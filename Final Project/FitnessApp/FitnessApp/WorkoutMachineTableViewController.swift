//
//  WorkoutMachineTableViewController.swift
//  FitnessApp
//
//  Created by Lauren Fisher on 12/13/20.
//

import UIKit

class WorkoutMachineTableViewController: UITableViewController {


    var category: String? = nil
    var chosenMachineArray2 = UserDefaults.standard.object(forKey: "chosenMachineArray2") as? [String] ?? [String]()
    
    


        override func viewDidLoad() {
            //chosenMachineArray2.removeAll()
            print("count from view did load:  \(chosenMachineArray2.count)")
            super.viewDidLoad()
            
            
            if let category = category {
                self.navigationItem.title = "\(category) Machines"
            }
        }

        // MARK: - Table view data source
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if section == 0 {
                return chosenMachineArray2.count
            }
            else {
                return 0
            }
        }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChosenMachineCell", for: indexPath)

            let chosenMachine = chosenMachineArray2[indexPath.row]
            cell.textLabel?.text = chosenMachine
            cell.textLabel?.font = UIFont(name: "Menlo-Bold", size: 20.0)
            cell.textLabel?.textColor = UIColor(red: 35/255.0, green: 171/255.0, blue: 175/255.0, alpha: 1)

            return cell
        }
        

        // Override to support editing the table view.
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                chosenMachineArray2.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }

        // Override to support rearranging the table view.
        override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let chosenMachine = chosenMachineArray2.remove(at: sourceIndexPath.row)
            chosenMachineArray2.insert(chosenMachine, at: destinationIndexPath.row)
            tableView.reloadData()
        }
        
        
        @IBAction func addBarButtonPressed(_ sender: UIBarButtonItem) {

        }
    
    @IBAction func unwindToAvailableMachinesTable(sender: UIStoryboardSegue) {
        print("unwinding?")
        if let availableMachineVC = sender.source as? ChooseMachineWorkoutTableViewController {
            print("unwinding correctly")
            let machineArray = availableMachineVC.chosenMachineArray
           
            
            chosenMachineArray2 = machineArray
            
            
            UserDefaults.standard.set(chosenMachineArray2, forKey: "chosenMachineArray2")
            
            print("count from unwind:  \(chosenMachineArray2.count)")
                    tableView.reloadData()
    }



}
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
            
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

            
        }
        tableView.deselectRow(at: indexPath, animated: true)

    
}
}
