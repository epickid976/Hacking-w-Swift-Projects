//
//  LoadView.swift
//  Territorios
//
//  Created by Jose Blanco on 1/2/23.
//

import Foundation
import SwiftUI

struct LoadView: View{
    @StateObject var state = StartupManager()
    var db = DataBaseManager()
    private var onLogged: () -> Void
    
    init(onLogin: @escaping () -> Void) {
        self.onLogged = onLogin
    }
    
    @State private var downloadErrorMessage = String()
    @State private var downloadErrorBool = Bool()
    
    var body: some View {
        NavigationView{
            ProgressView("LOADING...")
                .tint(.blue)
            
            
        }
        .onAppear() {
            LoginScreen.congregationID = db.getCongegation() ?? Congregation(id: 0000, name: "Blank")
            loadData(onError: { error in
                downloadErrorMessage = error.localizedDescription
                downloadErrorBool = true
            }, onFinish: {
                onLogged()
            })
        }
        .alert(downloadErrorMessage, isPresented: $downloadErrorBool) {
            Button("OK", role: .cancel) { downloadErrorBool = false}
            
        }
    }
}
