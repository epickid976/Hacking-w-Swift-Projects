//
//  LoadData.swift
//  Territorios
//
//  Created by Jose Blanco on 12/30/22.
//

import Foundation

func loadData(onError: @escaping (Error) -> Void, onFinish: @escaping () -> Void) {
    let api = API_Manager()
    let db = DataBaseManager()
    
    var territoriesAPI: [Territory] = []
    var housesAPI = [House]()
    var visitsAPI = [Visit]()
    var territoriesDb = db.territories
    var housesDb = db.houses
    var visitsDb = db.visits
    
    
    //Collect Data from DataBase
    var failure = false
    
    let waiter = WaiterLaunch() {
        if !failure {
            territoriesAPI.forEach { territory in

                    if let territoryDb = territoriesDb.first(where: {$0.getId() == territory.getId()}) {
                    
                    if !territory.equals(other: territoryDb) {
                        _ = db.updateTerritory(territory: territory)
                    }
                    
                    if let firstIndex = territoriesDb.firstIndex(where: {$0.getId() == territoryDb.getId()}) {
                        territoriesDb.remove(at: firstIndex)
                    }
                    
                } else {
                    _ = db.addTerritory(territory: territory)
                }
            }
            territoriesDb.forEach{ territory in
                _ = db.deleteTerritory(territory: territory)
            }
            
            housesAPI.forEach{ house in
                if let houseDb = housesDb.first(where: {$0.getId() == house.getId()}) {
                    
                    if !house.equals(other: houseDb){
                        _ = db.updateHouse(house: house)
                    }
                    
                    if let firstIndex = housesDb.firstIndex(where: {$0.getId() == houseDb.getId()}) {
                        housesDb.remove(at: firstIndex)
                    }
                } else {
                    _ = db.addHouse(house: house)
                }
            }
            housesDb.forEach{ house in
                _ = db.deleteHouse(house: house)
            }
            
            visitsAPI.forEach{ visit in
                if let visitDb = visitsDb.first(where: {$0.getId() == visit.getId()}){
                    
                    if !visit.equals(other: visitDb) {
                        _ = db.updateVisit(visit: visit)
                    }
                    
                    if let firstIndex = visitsDb.firstIndex(where: {$0.getId() == visitDb.getId()}) {
                        visitsDb.remove(at: firstIndex)
                    }
                } else {
                    _ = db.addVisit(visit: visit)
                }
            }
            visitsDb.forEach{ visit in
                _ = db.deleteVisit(visit: visit)
            }
            
            
            onFinish()
        } else {
            print("FAILURE CHANGED")
        }
    }
    
    waiter.enterRequest()
    waiter.enterRequest()
    waiter.enterRequest()
    //Collect All Data from Server
    api.getTerritories(congregationId: "\(LoginScreen.congregationID.id)", onSuccess: { territories in
        territoriesAPI.append(contentsOf: territories)
        waiter.leaveRequest()
    }, onError: { error in
        onError(error)
        print(error)
        failure = true
        print(failure)
        return
    })
    
    api.getAllHouses(congregationId: "\(LoginScreen.congregationID.id)", onSuccess: { houses in
        housesAPI.append(contentsOf: houses)
        waiter.leaveRequest()
    }, onError: { error in
        onError(error)
        print(error)
        failure = true
        print(failure)
        return
    })
    
    api.getAllVisits(congregationId: "\(LoginScreen.congregationID.id)", onSuccess: {visits in
        visitsAPI.append(contentsOf: visits)
        waiter.leaveRequest()
    }, onError: { error in
        onError(error)
        print(error)
        failure = true
        print(failure)
        return
    })
}
