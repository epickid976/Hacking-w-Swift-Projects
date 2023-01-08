//
//  API_Manager.swift
//  Territorios
//
//  Created by Jose Blanco on 12/30/22.
//

import Foundation
import Alamofire
import SwiftUI

class API_Manager {
    
    func getTerritories(congregationId: String, onSuccess: @escaping ([Territory]) -> Void, onError: @escaping (Error) -> Void) {
        getRequest(url: "territories/\(congregationId)") { result, error in
            
            if let result = result {
                print("Territories get result:\(result)")
                do {
                    let decoder = JSONDecoder()
                    let jsonData = result.data(using: .utf8)!
                    
                    let territories = try decoder.decode([Territory].self, from: jsonData)
                    
                    onSuccess(territories)
                } catch {
                    print("Error Json: \(error)")
                   onError(error)
                }
                
            } else {
                onError(error ?? NSError())
            }
        }
    }
    
    
    func getHousesOfTerritory(territoryId: String, onSuccess: @escaping ([House]) -> Void, onError: @escaping (Error) -> Void){
        getRequest(url: "houses/\(territoryId)") { result, error in
            if let result = result {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = result.data(using: .utf8)!
                    
                    let houses = try decoder.decode([House].self, from: jsonData)
                    
                    onSuccess(houses)
                    
                } catch {
                   onError(error)
                }
                
            } else {
                onError(error ?? NSError())
            }
        }
    }
    
    func getVisitsOfHouse(houseId: String, onSuccess: @escaping ([Visit]) -> Void, onError: @escaping (Error) -> Void){
        getRequest(url: "visits/\(houseId)") { result, error in
            if let result = result {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = result.data(using: .utf8)!
                    
                    let visits = try decoder.decode([Visit].self, from: jsonData)
                    
                    onSuccess(visits)
                } catch {
                   onError(error)
                }
                
            } else {
                onError(error ?? NSError())
            }
        }
    }
    
    func addVisit(visit: Visit, onResult: @escaping (Bool) -> Void, onError: @escaping (Error) -> Void) {
        postRequest(url: "visits/new", body: visit , method: .post) { result, error in
            if result != nil {
                onResult(true)
            } else {
                onError(NSError())
            }
        }
    }
    
    func updateVisit(visit: Visit, onResult: @escaping (Bool) -> Void, onError: @escaping (Error) -> Void) {
        postRequest(url: "visits/update", body: visit , method: .post) { result, error in
            if result != nil {
                onResult(true)
            } else {
                onError(NSError())
            }
        }
    }
    
    
    func updateHouse(house: House, onResult: @escaping (Bool) -> Void, onError: @escaping (Error) -> Void) {
        postRequest(url: "houses/update", body: house , method: .post) { result, error in
            if result != nil {
                onResult(true)
            } else {
                onError(NSError())
            }
        }
    }
    
    func getAllHouses(congregationId: String, onSuccess: @escaping ([House]) -> Void, onError: @escaping (Error) -> Void) {
        getRequest(url: "houses/all/\(congregationId)") { result, error in
            
            if let result = result {
                print("Houses get result:\(result)")
                do {
                    let decoder = JSONDecoder()
                    let jsonData = result.data(using: .utf8)!
                    
                    let houses = try decoder.decode([House].self, from: jsonData)
                    
                    onSuccess(houses)
                } catch {
                    print("Error Json: \(error)")
                    onError(error)
                }
                
            } else {
                onError(error ?? NSError())
            }
        }
    }
    
    func getAllVisits(congregationId: String, onSuccess: @escaping ([Visit]) -> Void, onError: @escaping (Error) -> Void) {
        getRequest(url: "visits/all/\(congregationId)") { result, error in
            
            if let result = result {
                print("Visits get result:\(result)")
                do {
                    let decoder = JSONDecoder()
                    let jsonData = result.data(using: .utf8)!
                    
                    let visits = try decoder.decode([Visit].self, from: jsonData)
                    
                    onSuccess(visits)
                } catch {
                    print("Error Json: \(error)")
                    onError(error)
                }
                
            } else {
                onError(error ?? NSError())
            }
        }
    }
    
}
