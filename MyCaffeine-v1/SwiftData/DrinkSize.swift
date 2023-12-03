//
//  DrinkSize.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 30/11/2023.
//

import Foundation
import SwiftData

@Model
final class DrinkSize {
    var timestamp: Date
//    var name: String
    var size: Double
    var caffeineContent: Double
    var waterContent: Double
    
    init(timestamp: Date = Date.now, size: Double = 300.0, caffeineContent: Double = 15.0, waterContent: Double = 300.0) {
        self.timestamp = timestamp
        self.size = size
        self.caffeineContent = caffeineContent
        self.waterContent = waterContent
    }
}
