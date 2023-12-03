//
//  Helpers.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 01/12/2023.
//

import Foundation

class Helpers {
    
    
    static func populateImageArray() -> Array<String> {
        var images = [String]()
        var iteration = 0
        let imagePrefix = ["coffeeBean", "coffeeCup", "coffeeFilter", "coffeeIced", "coffeeTakeaway", "teabag", "sodaBottle", "sodaCan", "sodaCup", "sodaGlass"]
        let imagePrefixMaxImages = [03, 10, 05, 08, 17, 03, 19, 29, 08, 04]
        
        for prefix in imagePrefix {
            for index in 1...imagePrefixMaxImages[iteration] {
                images.append(prefix + "\(index)")
            }
            
            iteration += 1
        }
        
        
        return images
    }
}

