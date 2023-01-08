//
//  StartupManager.swift
//  Territorios
//
//  Created by Jose Blanco on 1/2/23.
//

import Foundation


class StartupManager: ObservableObject {
    
    @Published var state: StartState = .NONE
    @Published var firstTime: Bool = false
    let db = DataBaseManager()
    
    init() {
        getState()
    }
    
    func getState() {
    
        if needLogin() {
            self.state = .LOGIN
        } else if needLoad() {
            self.state = .LOAD
        } else {
            self.state = .READY
        }

    }
    
    func setState(state: StartState){
        self.state = state
    }
    
    
    func needLogin() -> Bool {
        return db.getCongegation() == nil
    }
    
    func needLoad() -> Bool {
        return true
    }
    
}

enum  StartState {
    case NONE
    case LOGIN
    case LOAD
    case READY
}
