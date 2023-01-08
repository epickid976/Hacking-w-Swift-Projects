//
//  DataLoader.swift
//  Territorios
//
//  Created by Jose Blanco on 1/2/23.
//

import Foundation


class DataLoader {
    
    let api = API_Manager()
    
    private func updateHouse(house: House, onResult: @escaping (Bool) -> Void) {
        api.updateHouse(house: house, onResult: {_ in
            onResult(true)
        }, onError: {_ in
            onResult(false)
        })
    }
    
    func automaticUpdateHouse(house: House, onResult: @escaping (Bool) -> Void) {
        updateHouse(house: house, onResult: { result in
            onResult(result)
            if !result {
                self.automaticUpdateHouse(house: house, onResult: onResult)
            }
        })
    }
    
    private func uploadVisit(visit: Visit, onResult: @escaping (Bool) -> Void) {
        api.addVisit(visit: visit, onResult: {_ in
            onResult(true)
        }, onError: {_ in
            onResult(false)
        })
    }
    
    func automaticUploadVisit(visit: Visit, onResult: @escaping (Bool) -> Void) {
        uploadVisit(visit: visit, onResult: { result in
            onResult(result)
            if !result {
                self.automaticUploadVisit(visit: visit, onResult: onResult)
            }
        })
    }
    
}
