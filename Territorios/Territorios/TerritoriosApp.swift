//
//  TerritoriosApp.swift
//  Territorios
//
//  Created by Jose Blanco on 12/25/22.
//

import SwiftUI
import Alamofire

@main
struct TerritoriosApp: App {
    @StateObject var alerter: Alerter = Alerter()
    @StateObject var state = StartupManager()
    
    var body: some Scene {
        WindowGroup {
            
            switch state.state {
            case .LOGIN:
                LoginScreen() {
                    state.getState()
                }
            case .LOAD:
                LoadView() {
                    state.setState(state: .READY)
                }
            case .READY:
                TerritoriesView()
            default:
                BlankView()
            }
        }
    }
}
