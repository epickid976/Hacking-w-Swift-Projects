//
//  DatabaseManager.swift
//  Territorios
//
//  Created by Jose Blanco on 12/30/22.
//

import Foundation
import SwiftUI


class DataBaseManager: ObservableObject {
    private let storage = UserDefaultsStorage.shared
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    @Published var territories = [Territory]()
    @Published var houses = [House]()
    @Published var visits = [Visit]()
    
    
    
    func getAllTerritories() -> [Territory] {
        
        do {
            print("Just Early")
            
            let data = storage.getTerritories()
            
            guard let data = data else {
                print("Went to guard")
                return []
            }
            
            return try decoder.decode([Territory].self, from: data)
        } catch {
            return []
        }
    }
    
    func getHousesOfTerritory(territoryId: String) -> [House] {
        
        do {
            let data = storage.getHouses()
            
            guard let data = data else {
                return []
            }
            
            let houses = try decoder.decode([House].self, from: data)
            
            return houses.filter { $0.territory == territoryId }
        }catch {
            return []
        }
        
    }
    
    func addTerritory(territory: Territory) -> Bool {
        
        do {
            var territories = getAllTerritories()
            let test = territories.firstIndex(where: { territory.getId() == $0.getId() }) == nil
            guard territories.firstIndex(where: { territory.getId() == $0.getId() }) == nil else {
                return false
            }
            territories.append(territory)
            let data = try encoder.encode(territories)
            
            storage.saveTerritories(data: data)
            
            self.territories = territories
            
            return true
        } catch {
            return false
        }
        
    }
    
    func updateTerritory(territory: Territory) -> Bool {
        
        if !deleteTerritory(territory: territory) {
            return false
        }
        
        return addTerritory(territory: territory)
        
    }
    
    func deleteTerritory(territory: Territory) -> Bool{
        
        var territories = getAllTerritories()
        
        guard let index = territories.firstIndex(where: { $0.getId() == territory.getId( ) }) else {
            return false
        }
        
        territories.remove(at: index)
        
        do {
            storage.saveTerritories(data: try encoder.encode(territories))
            self.territories = territories
            return true
        }catch {
            return false
        }
        
    }
    
    func getAllHouses() -> [House] {
        do {
            let data = storage.getHouses()
            
            guard let data = data else {
                return []
            }
            
            return try decoder.decode([House].self, from: data)
        } catch {
            return []
        }
    }
    
    func getVisitsOfHouse(houseId: String) -> [Visit] {
        
        do {
            let data = storage.getVisits()
            
            guard let data = data else {
                return []
            }
            
            let visits = try decoder.decode([Visit].self, from: data)
            
            return visits.filter { $0.house == houseId }
        }catch {
            return []
        }
        
    }
    
    func addHouse(house: House) -> Bool {
        
        do {
            var houses = getAllHouses()
            
            guard houses.firstIndex(where: { house.getId() == $0.getId() }) == nil else {
                return false
            }
            houses.append(house)
            let data = try encoder.encode(houses)
            
            storage.saveHouses(data: data)
            
            self.houses = houses
            
            return true
        } catch {
            return false
        }
    }
    
    func updateHouse(house: House) -> Bool {
        if !deleteHouse(house: house) {
            return false
        }
        
        return addHouse(house: house)
    }
    
    func deleteHouse(house: House) -> Bool {
        var houses = getAllHouses()
        
        guard let index = houses.firstIndex(where: { $0.getId() == house.getId( ) }) else {
            return false
        }
        
        houses.remove(at: index)
        
        do {
            storage.saveHouses(data: try encoder.encode(houses))
            self.houses = houses
            return true
        }catch {
            return false
        }
    }
    
    func getAllVisits() -> [Visit]{
        do {
            let data = storage.getVisits()
            
            guard let data = data else {
                return []
            }
            
            return try decoder.decode([Visit].self, from: data)
        } catch {
            return []
        }
    }
    func addVisit(visit: Visit) -> Bool {
        
        do {
            var visits = getAllVisits()
            
            guard visits.firstIndex(where: { visit.getId() == $0.getId() }) == nil else {
                return false
            }
            
            visits.append(visit)
            let data = try encoder.encode(visits)
            
            storage.saveVisits(data: data)
            
            self.visits = visits
            
            return true
        } catch {
            return false
        }
    }
    
    func updateVisit(visit: Visit) -> Bool {
        if !deleteVisit(visit: visit) {
            return false
        }
        
        return addVisit(visit: visit)
    }
    
    func deleteVisit(visit: Visit) -> Bool {
        var visits = getAllVisits()
        
        guard let index = visits.firstIndex(where: { $0.getId() == visit.getId( ) }) else {
            return false
        }
        
        visits.remove(at: index)
        
        do {
            storage.saveVisits(data: try encoder.encode(visits))
            self.visits = visits
            return true
        }catch {
            return false
        }
    }
    
    func addCongregation(congregation: Congregation) -> Bool {
        do {
            storage.saveCongregation(data: try encoder.encode(congregation))
            return true
        } catch {
            return false
        }
    }
    
    func getCongegation() -> Congregation? {
        do {
            let data = storage.getCongregation()
            
            guard let data = data else {
                return nil
            }
            
            return try decoder.decode(Congregation.self, from: data)
        } catch {
            return nil
        }
    }
    
    class var shared: DataBaseManager {
        struct Static {
            static let instance = DataBaseManager()
        }
        
        return Static.instance
    }
    
}


