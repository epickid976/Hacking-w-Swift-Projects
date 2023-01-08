//
//  AlertClass.swift
//  Territorios
//
//  Created by Jose Blanco on 12/30/22.
//

import Foundation
import Alamofire
import SwiftUI

class Alerter: ObservableObject {
    @Published var alert: Alert? //{
    //  didSet { isShowingAlert = alert != nil }
    // }
    @Published var isShowingAlert = false
    @Published var errorMessage = String()
    @Published var errorTitle = String()
    
}

extension UserDefaults {
    enum Keys: String, CaseIterable {
        case territoryKey = "territoryK"
        case  housesKey = "housesK"
        case visitsKey = "visitsK"
        
    }
    
    func reset() {
        Keys.allCases.forEach {
            removeObject(forKey: $0.rawValue)
        }
    }
}
