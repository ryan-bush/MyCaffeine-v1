//
//  Log.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 30/11/2023.
//

import Foundation
import SwiftData

@Model
final class Log {
    var timestamp: Date
    var uuid: UUID
    
    var drinkName: String
    var drinkImage: String
    var caffeine: Double
    var water: Double
    
    init(timestamp: Date = Date.now, uuid: UUID = UUID(), drinkName: String = "", drinkImage: String = "", caffeine: Double = 0.0, water: Double = 0.0) {
        self.timestamp = timestamp
        self.uuid = uuid
        self.drinkName = drinkName
        self.drinkImage = drinkImage
        self.caffeine = caffeine
        self.water = water
    }
}

