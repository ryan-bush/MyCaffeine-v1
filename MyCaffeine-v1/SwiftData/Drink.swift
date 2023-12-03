//
//  Drink.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 30/11/2023.
//

import Foundation
import SwiftData

@Model
final class Drink {
    var timestamp: Date
    var uuid: UUID
    var name: String
    var image: String
    var caffeineType: Int // 0 - mg/100ml | 1 - fixed sizes
    var caffeineContent: Double
    @Relationship(deleteRule: .cascade) var drinkSizes = [DrinkSize]()
    
    init(timestamp: Date = Date.now, uuid: UUID = UUID(), name: String = "", image: String = "", caffeineType: Int = 0, caffeineContent: Double = 10.5) {
        self.timestamp = timestamp
        self.uuid = uuid
        self.name = name
        self.image = image
        self.caffeineType = caffeineType
        self.caffeineContent = caffeineContent
    }
}
