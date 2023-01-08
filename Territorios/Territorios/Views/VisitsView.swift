//
//  VisitsView.swift
//  Territorios
//
//  Created by Jose Blanco on 1/3/23.
//

import Foundation
import SwiftUI
import UIKit

struct VisitsView: View{
    private var house: House
    private var toggleOn: Bool
    
    @State var showPopup = false
    
    init(house: House, toggleOn: Bool){
        self.house = house
        self.toggleOn = toggleOn
    }
    
    let db = DataBaseManager()
    let dl = DataLoader()
    @State var newVisitNote = String()
    @State var languageSelection = "Spanish"
    let languageSelections = ["Spanish", "English"]
    
    @State private var uploadVisitAlertError = false
    
    
    @Environment(\.colorScheme) var colorScheme
    
    
    
    var body: some View {
        ZStack {
            NavigationStack{
                let getVisits = db.getVisitsOfHouse(houseId: house.getId())
                let getVisitsArray = db.visits
                let visits = getVisitsArray.sorted {
                    $0.date < $1.date
                }
                
                if !visits.isEmpty {
                    ScrollView{
                        VStack {
                            
                            
                            
                            ForEach(visits, id: \.id) { visit in
                                
                                ZStack(alignment: .leading) {
                                    
                                    if colorScheme == .dark {
                                        Color.flatDarkCardBackground
                                    } else {
                                        Color(UIColor.lightGray).opacity(0.5)
                                    }
                                    
                                    HStack {
                                        
                                        VStack(alignment: .leading) {
                                            
                                            Text(visit.notes)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .lineLimit(2)
                                                .padding(.bottom, 5)
                                            
                                            Text("\(visit.date)")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .lineLimit(2)
                                                .padding(.bottom, 5)
                                        }
                                        .padding(.horizontal, 5)
                                    }
                                    .padding(15)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                
                                
                                //.aspectRatio(contentMode: .fit)
                            }
                            .padding(5)
                        }
                        
                    }
                } else {
                    Text("No Visits")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .font(.system(size: 36))
                }
                
            }
            .navigationBarTitle("House: \(house.number)", displayMode: .large)
            .navigationBarItems(trailing: Image(systemName: "plus").onTapGesture {
                showPopup = true
            })
            
        }
        
        .popup(isPresented: $showPopup, dragToDismiss: false, closeOnTap: false, closeOnTapOutside: false) {
                    let date = Date.timeIntervalBetween1970AndReferenceDate * 1000
                    let id = "\(LoginScreen.congregationID.id)-\(house.territory)-\(house.number)-\(date)"
                    let houseIdForUpload = "\(LoginScreen.congregationID.id)-\(house.territory)-\(house.number)"
                    let by_phone = Bool()
                    
                    //Created_at
                    let created_at = getDate()
                    
                    HStack {
                        Spacer()
                        VStack {
                                
                            Spacer()
                            Text("New Visit")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            VStack(alignment: .leading) {
                                            
                                            HStack {
                                                TextField("Type Note", text: $newVisitNote, axis: .vertical)
                                                   
                                            }
                                            .textFieldStyle(OvalTextFieldStyle())
                                        }.padding()
                        
                            
                                Spacer()
                            
                                Picker("Language Selector", selection: $languageSelection) {
                                    ForEach(languageSelections, id: \.self){
                                        Text($0)
                                    }
                                }.pickerStyle(.segmented)
                                .padding(10)
                            
                            Spacer()
                            
                            
                            Button (action: {
                                if newVisitNote.isEmpty{
                                    uploadVisitAlertError = true
                                    print("Error")
                                } else {
                                    
                                    updateOrCreateVisit(visit: Visit(id: id, house: house.id, date: Int64(date), notes: newVisitNote, by_phone: by_phone, created_at: nil, updated_at: nil), house: house, update: false) {
                                        
                                        //Make a Toast to notify something is wrong
                                    }
                                    
                                    showPopup = false
                                }
                            }) {
                            Text("Done")
                                    .frame(width: 100, height: 50, alignment: .center)
                                    .font(.headline)
                                    .fontWeight(.bold)
                            } .buttonStyle(.borderedProminent)
                                .foregroundColor(Color.white)
                                .cornerRadius(5)
                                .alert("Please type a note for the new visit.", isPresented: $uploadVisitAlertError) {
                                    Button("OK", role: .cancel) { uploadVisitAlertError = false}
                                }
                           
                            Spacer()
                            
                        }
                        
                        Spacer()

                    }
                    .frame(width: 400, height: 400)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.teal]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(15)
                    .shadow(color: .gray, radius: 10)
                    
                }
        .toolbar{
            ToolbarItemGroup(placement: .keyboard){
                Spacer()
                
                Button("Done"){
                    DispatchQueue.main.async {
                        hideKeyboard()
                    }
                }
                
            }
        }
        
        }
    func getDate() -> String {
        let date = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let created_At = dateFormat.string(from: date)
        return created_At
    }
    
    func visitsFilter(visits: [Visit]) -> [Visit]{
        if toggleOn {
            let visitsArray = visits.filter ({ $0.by_phone == true
            })
            
            return visitsArray
        } else {
            let visitsArray = visits.filter ({ $0.by_phone == false
              })
            return visitsArray
        }
    }
    
    func updateOrCreateVisit(visit: Visit, house: House, update: Bool, onFailed: @escaping () -> Void) {
        
        if update {
            db.updateVisit(visit: visit)
        } else {
            db.addVisit(visit: visit)
        }
        
        db.updateHouse(house: house)
        
        dl.automaticUploadVisit(visit: visit) { result in
            
            if !result {
                onFailed()
            }
            
        }
        
        dl.automaticUpdateHouse(house: house) { result in
            
        }
        
    }
        
}


struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        configuration
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 10)
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
