//
//  UserViewModel.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 24/12/2023.
//

import Foundation
import SwiftUI
import RevenueCat

class UserViewModel: ObservableObject {
    
    @Published var isSubscriptionActive = false
    
    init() {
        
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            
                
            self.isSubscriptionActive = customerInfo?.entitlements.all["pro"]?.isActive == true
            
        }
    }
    
}
