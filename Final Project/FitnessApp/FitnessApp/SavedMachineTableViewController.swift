//
//  SavedMachineTableViewController.swift
//  FitnessApp
//
//  Created by Lauren Fisher on 12/5/20.
//

import UIKit
import WebKit

class SavedMachineTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var mainView: UIView!
    var machineNameArray = [String]()
    var machines = [Machine]()
    let webView = WKWebView()
    
//    func initializeMachines() {
//        machines.append(Machine(name: "Hip Abductors", weight: 20, numReps: 2, description: "",  tutorialLink: ""))
//        machines.append(Machine(name: "Legs", weight: 30, numReps: 3, description: "", tutorialLink: ""))
//    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return machines.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let machine = machines[row]
        
        // now we need a DogTableViewCell!!
        let cell = tableView.dequeueReusableCell(withIdentifier: "MachineCell", for: indexPath) as! SavedMachineCellTableViewCell
        
        

        // we don't need to create a "new cell" for each our dogs and here is why
        // lets say there are 10000 dogs in our dogs array
        // we don't need 100000 cells because there won't be 10000 cells display at one time in our table view
        
        cell.update(with: machine)
        cell.tutorialButton.tag = indexPath.row
        cell.tutorialButton.addTarget(self, action: "tutorialButtonClicked:", for: UIControl.Event.touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))

            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            label.text = "      MACHINE NAME      REPS      WEIGHT      LINK"
           
        label.textColor = .white

            headerView.addSubview(label)

            return headerView
        }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
        }

    override func viewDidLoad() {
        tableView.backgroundColor = nil
        mainView = view
    
        tableView.backgroundView = nil
        tableView.sectionHeaderHeight = 70
        super.viewDidLoad()
        //initializeMachines()
        
        UserDefaults.standard.set(machineNameArray, forKey: "machineNameArray")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "DetailSegue" {
                print("detail segue")
                if let machineDetailVC = segue.destination as? SavedMachineDetailView {
                    //we need to get index path for row user clicked on
                    //need to get dog in that row and pass the dog into DetailCiewController
                    if let indexPath = tableView.indexPathForSelectedRow {
                        let machine = machines[indexPath.row]
                        machineDetailVC.machineOptional = machine
                        //tableView.deselectRow(at: indexPath, animated: true)
                    }
                }
            }
            
            else if identifier == "addSegue" {
                print("add segue")
//                    if let indexPath = tableView.indexPathForSelectedRow {
//                        tableView.deselectRow(at: indexPath, animated: true)
//                    }

            }
            else {
                print("idk what segue this is")
            }
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

    }
    
    @IBAction func unwindToSavedMachinesTable(sender: UIStoryboardSegue)
    {
        if let identifier = sender.identifier {
            print("scanned machine unwind")
            if identifier == "SaveUnwindSegue" {
                if let machineDetailVC = sender.source as? SavedMachineDetailView {
                    if let machine = machineDetailVC.machineOptional {
                        //get currently selected index path
                        if tableView != nil {
                            print("table view isnt nil")
                        if let indexPath = tableView.indexPathForSelectedRow {
                            print("saving to previously defined machine")
                            machines[indexPath.row] = machine
                            tableView.deselectRow(at: indexPath, animated: true)
                            tableView.reloadData()
                        }
                        else {


                            print("appending machine with table view from add or scan after table view")
                            machines.append(machine)
                            machineNameArray.append(machine.name)
                            UserDefaults.standard.set(machineNameArray, forKey: "machineNameArray")

                            tableView.reloadData()
                        }
                        }
                        else {

                            print("appending machine2 before table view loaded")
                            machines.append(machine)
                            machineNameArray.append(machine.name)
                            UserDefaults.standard.set(machineNameArray, forKey: "machineNameArray")
                            
                            //tableView.reloadData()
                        }
                        
                }
                }
            }
            else {
                print("scanned machine unwind idk what to do")
            }
        }
        //UserDefaults.standard.set(machineNameArray, forKey: "machineNameArray")
    }
    
    @IBAction func unwindFromCancelAddingMachine(sender: UIStoryboardSegue)
    {
        if let identifier = sender.identifier {
            if identifier == "cancelUnwind" {
                print("cancel unwind")
            }
        }
    }
    
    @IBAction func tutorialButtonClicked(_ sender: UIButton) {
        let buttonRow = sender.tag
        print("button pressed")
        let machine = machines[buttonRow]
            print("machine exists")
            print(machine.tutorialLink)
            if let link = URL(string: machine.tutorialLink) {
                print("trying to do webkit")
                self.view = self.webView
                let request = URLRequest(url: link)
                self.webView.load(request)
            
        }
        
        
    
}
    
    @IBAction func backToTablePressed(sender: UIBarItem) {
        print("get out of webView")
        self.view = mainView
        webView.stopLoading()
}




}
