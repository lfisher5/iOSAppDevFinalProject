//
//  SavedMachineDetailView.swift
//  FitnessApp
//
//  Created by Lauren Fisher on 12/5/20.
//

import UIKit
import WebKit

class SavedMachineDetailView: UIViewController {
    
    var machineOptional: Machine? = nil
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var numRepTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var tutorialButton: UIButton!
    let webView = WKWebView()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        if let machine = machineOptional {
            nameTextField.text = machine.name
            numRepTextField.text = String(machine.numReps)
            weightTextField.text = String(machine.weight)
            descriptionTextField.text = String(machine.description)
            if machine.tutorialLink == "" {
                tutorialButton.isHidden = true
            }
            print(machine.tutorialLink)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            if identifier == "SaveUnwindSegue" {
                if let name = nameTextField.text, let rep = numRepTextField.text, let weight = weightTextField.text, let description = descriptionTextField.text {
                    if let machine = machineOptional {
                        print("in save unwind segue")
                        print(machine.tutorialLink)
                        machine.name = name
                        machine.description = description
                        if let repInt = Int(rep), let weightFloat = Float(weight) {
                            machine.numReps = repInt
                            machine.weight = weightFloat
                        }
                        
                    }
                    else {
                        print("in add unwind segue")
                        //there is no dog passed in...
                        //we got here via an AddSegue
                        if let repInt = Int(rep), let weightFloat = Float(weight) {
                        
                            self.machineOptional = Machine(name: name, weight: weightFloat, numReps: repInt, description: description, tutorialLink: "")
                    }
                    }
                }
            }
        }
    }
    
    @IBAction func tutorialLinkPressed(sender: UIButton) {
        print("button pressed")
        if let machine = machineOptional {
            print("machine exists")
            print(machine.tutorialLink)
            if let link = URL(string: machine.tutorialLink) {
                print("trying to do webkit")
                self.view = self.webView
                let request = URLRequest(url: link)
                self.webView.load(request)
                //UIApplication.shared.open(link)
            }
        }
    }
}
