//
//  UserDefaultsStorage.swift
//  Territorios
//
//  Created by Jose Blanco on 12/30/22.
//

import Foundation
import SwiftUI

class UserDefaultsStorage: ObservableObject {
    let defaults = UserDefaults.standard
    
    
    private let congreKey = "CongreK"
    private let territoryKey = "territoryK"
    private let housesKey = "housesK"
    private let visitsKey = "visitsK"
    
    func getTerritories() -> Data? {
        if let object = defaults.object(forKey: territoryKey) as? Data {
            return object
        } else {
            return nil
        }
    }
    
    func saveTerritories(data: Data) {
        defaults.set(data, forKey: territoryKey)
    }
    
    func getHouses() -> Data? {
        if let object = defaults.object(forKey: housesKey) as? Data {
            return object
        } else {
            return nil
        }
        
    }
    
    func saveHouses(data: Data) {
        defaults.set(data, forKey: housesKey)
    }
    
    func getVisits() -> Data? {
        if let object = defaults.object(forKey: visitsKey) as? Data {
            return object
        } else {
            return nil
        }
        
        
    }
    
    func saveVisits(data: Data) {
        defaults.set(data, forKey: visitsKey)
    }
    
    func getCongregation() -> Data? {
        if let object = defaults.object(forKey: congreKey) as? Data {
            return object
        } else {
            return nil
        }
    }
    func saveCongregation(data: Data) {
        defaults.set(data, forKey: congreKey)
    }
    
    class var shared: UserDefaultsStorage {
        struct Static {
            static let instance = UserDefaultsStorage()
        }
        
        return Static.instance
    }
}
