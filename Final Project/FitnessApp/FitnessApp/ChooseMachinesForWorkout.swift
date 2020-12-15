//
//  ChooseMachinesForWorkout.swift
//  FitnessApp
//
//  Created by Lauren Fisher on 12/13/20.
//


import UIKit

class ChooseMachineWorkoutTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    
    @IBOutlet var tableView: UITableView!
    var availableMachineArray : [String] = UserDefaults.standard.object(forKey: "machineNameArray") as? [String] ?? [String]()
    var chosenMachineArray = [String]()


        var selectedMachineArray = [String]()

        override func viewDidLoad() {

            print("help")
            super.viewDidLoad()



            
            print(availableMachineArray)

            self.navigationItem.title = "Choose Machines For Your Workout"
            
        }

        // MARK: - Table view data source
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if section == 0 {
                print("weird")
                return availableMachineArray.count

                
            }
            else {
                print("huh")
                return 0
            }
        }

        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "machineArrayCell", for: indexPath)

           
            let chosenMachineName = availableMachineArray[indexPath.row]
            cell.textLabel?.text = chosenMachineName
            cell.textLabel?.font = UIFont(name: "Menlo-Bold", size: 20.0)
            cell.textLabel?.textColor = UIColor(red: 35/255.0, green: 171/255.0, blue: 175/255.0, alpha: 1)
            
         

            return cell
        }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }

        // Override to support editing the table view.
         func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                availableMachineArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }

        // Override to support rearranging the table view.
         func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

            let item = availableMachineArray.remove(at: sourceIndexPath.row)
            availableMachineArray.insert(item, at: destinationIndexPath.row)
            tableView.reloadData()
            
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // this method executes when the user selects (taps) on a row
print("pressed cell")
        if tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            chosenMachineArray.append(availableMachineArray[indexPath.row])
            print(chosenMachineArray)
            
            
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            chosenMachineArray.remove(at: indexPath.row)
            
            
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let identifier = segue.identifier {
//            if identifier == "DetailSegue" {
//                print("detail segue")
//                if let machineDetailVC = segue.destination as? SavedMachineDetailView {
//                    //we need to get index path for row user clicked on
//                    //need to get dog in that row and pass the dog into DetailCiewController
//                    if let indexPath = tableView.indexPathForSelectedRow {
//                        machineDetailVC.machineOptional = machine
//                        tableView.deselectRow(at: indexPath, animated: true)
//                        }
//                    }
//                }
//            }
//        }
//    }
    

    
    
    
}
