//
//  SavedMachineCellTableViewCell.swift
//  FitnessApp
//
//  Created by Lauren Fisher on 12/5/20.
//

import UIKit

class SavedMachineCellTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var repLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var tutorialButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func update(with machine: Machine) {
        nameLabel.text = machine.name
        repLabel.text = String(machine.numReps)
        weightLabel.text = String(machine.weight)
        print("(" + machine.tutorialLink + ")")
        if machine.tutorialLink == "" {
            print("hello")
            tutorialButton.setTitleColor(UIColor(red: 117.0/255.0, green: 115.0/255.0, blue: 115.0/255.0, alpha: 1), for: .normal)
            tutorialButton.isOpaque = true
            tutorialButton.isEnabled = false
            
        }
    }
    


}
