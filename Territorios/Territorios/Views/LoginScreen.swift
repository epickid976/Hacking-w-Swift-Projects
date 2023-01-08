//
//  ContentView.swift
//  Territorios
//
//  Created by Jose Blanco on 12/5/22.
//

import SwiftUI
import Alamofire



struct LoginScreen: View {
    private var onLogged: () -> Void
    
    init(onLogin: @escaping () -> Void) {
        self.onLogged = onLogin
    }
    
    static var congregationID: Congregation = Congregation(id: 0, name: "")
    
    @State private var username: String = "1111"
    @State private var password: String = "reino1914"
    @State private var showAlerts = Bool()
    @State private var errorMess = String()
    @State private var errorTit = String()
    
    var BaseURL = "https://servicemaps.apps-smartsolutions.online/api/"
    
    static var territoriesDb = [Territory]()
    static var housesDb = [House]()
    var visitsDb = [Visit]()
    
    
    @State var presentingModal = false
    @State var isTyping: Bool = false
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        VStack {
            NavigationView{
                VStack{
                    
                    Spacer()
                        .frame(height: 5)
                    
                    //                        Text("Please enter Congregation number and Password.")
                    //                            .multilineTextAlignment(.center)
                    //                            .padding(10)
                    //                            .overlay(
                    //                                RoundedRectangle(cornerRadius: 20)
                    //                                    .stroke(.primary, lineWidth: 4)
                    //
                    //                            )
                    
                    
                    
                    Spacer()
                        .frame(height: 40)
                    
                    Image(uiImage: UIImage(named: "location-map-flat")!)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    HStack{
                        Spacer()
                            .frame(width: 50)
                        TextField("Username", text: $username, onEditingChanged: {
                            self.isTyping = $0
                        })
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
                        
                        //                                .toolbar{
                        //                                    ToolbarItemGroup(placement: .keyboard){
                        //                                        Spacer()
                        //
                        //                                        Button("Done"){
                        //                                            amountIsFocused = false
                        //                                        }
                        //                                    }
                        //                                }
                        Spacer()
                            .frame(width: 50)
                    }
                    
                    HStack{
                        Spacer()
                            .frame(width: 50)
                        TextField("Password", text: $password, onEditingChanged: {
                            self.isTyping = $0
                        })
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.default)
                        .focused($amountIsFocused)
                        
                        Spacer()
                            .frame(width: 50)
                    }
                    
                    Spacer()
                        .frame(height: 40)
                    
                    Button("Submit") {
                        
                        let log = Login(id: username, password: password)
                        login(log: log) { errorMessage, showAlert in
                            if let showAlert = showAlert {
                                showAlerts = showAlert
                                errorMess = errorMessage
                                
                            }
                            
                        } success: { congre in
                            let db = DataBaseManager()
                            LoginScreen.congregationID = congre
                            _ = db.addCongregation(congregation: congre)
                            onLogged()
                        }
                        
                        
                    }
                    .foregroundColor(.primary)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 20, style: .circular).fill(Color.blue))
                    .background()
                    .alert(errorMess, isPresented: $showAlerts) {
                        Button("OK", role: .cancel) { showAlerts = false}
                        
                    }
                    
            
                Spacer()
            }
            
            .navigationBarTitle("Login", displayMode: .automatic)
            //.navigationBarHidden(isTyping ? true : false)
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
    }
        .padding()
}
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen() {
            
        }
        
    }
}




