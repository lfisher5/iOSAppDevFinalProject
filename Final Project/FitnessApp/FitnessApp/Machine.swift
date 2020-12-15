//
//  Machine.swift
//  FitnessApp
//
//  Created by Lauren Fisher on 12/4/20.
//

import Foundation

class Machine {
    var name: String
    var weight: Float
    var numReps: Int
    var description: String
    var tutorialLink: String = ""
    

    init(name: String, weight: Float, numReps: Int, description: String, tutorialLink: String) {
        self.name = name
        self.weight = weight
        self.numReps = numReps
        self.description = description
        self.tutorialLink = tutorialLink
    }
    

}
