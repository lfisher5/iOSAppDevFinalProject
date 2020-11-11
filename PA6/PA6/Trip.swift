//Trip.swift
//this file handles all variables involving the trip object (dates, name, and image)
//CPSC 315
//PA6
//Any sources to cite? Sources listed below.
//Did you attempt the bonus? No
//
//  Created by Lauren Fisher on 10/31/20.
//  Copyright © 2020 Lauren Fisher. All rights reserved.
//

import Foundation

//Vacation Icon credit:
//Beach Chair: Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
//Mountain: Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
//Home: Icons made by <a href="https://www.flaticon.com/authors/vectors-market" title="Vectors Market">Vectors Market</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>

class Trip : CustomStringConvertible{

    
    var destinationName: String
    var startDate: Date
    var endDate: Date
    var imageFileName: String
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return destinationName + dateFormatter.string(from: startDate) + dateFormatter.string(from: endDate)
    }
    
    
    init(destinationName: String, startDate: Date, endDate: Date) {
        self.destinationName = destinationName
        self.startDate = startDate
        self.endDate = endDate
        if destinationName == "Home" {
        self.imageFileName = "house"
        }
        else if destinationName == "Fiji"{
            self.imageFileName = "beach-chair"
        }
        else {
            self.imageFileName = "mountain"
        }
        
    }
    
}
