//
//  HousesView.swift
//  Territorios
//
//  Created by Jose Blanco on 1/3/23.
//

import Foundation
import SwiftUI


struct HousesView: View{
    private var territory: Territory
    private var toggleOn: Bool
    
    init(territory: Territory, toggleOn: Bool){
        self.territory = territory
        self.toggleOn = toggleOn
    }
    
    @ObservedObject var db = DataBaseManager()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack{
            let getHouses = db.getHousesOfTerritory(territoryId: territory.getId())
            let getHousesArray = db.houses
            let houses = getHousesArray.sorted {
                Int($0.number)! < Int($1.number)!
            }
            
            
            if !houses.isEmpty {
            ScrollView{
                VStack {
                    ForEach(houses, id: \.number) { house in
                        NavigationLink(destination: VisitsView(house: house, toggleOn: toggleOn)){
                            ZStack(alignment: .leading) {
                                
                                if colorScheme == .dark {
                                    Color.flatDarkCardBackground
                                } else {
                                    Color(UIColor.lightGray).opacity(0.5)
                                }
                                
                                HStack {
                                    ZStack {
                                        Circle()
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [.blue, .teal]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                        
                                        VStack {
                                            Text("\(house.number)")
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(.white)
                                            
                                        }
                                    }
                                    .frame(width: 70, height: 70, alignment: .center)
                                    
                                    VStack(alignment: .leading) {
                                        if toggleOn {
                                            Text("Phone#: \(house.phone ?? "No Phone Number")")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .lineLimit(2)
                                                .padding(.bottom, 5)
                                        }
                                        
                                        Text("Language: \(determineLanguage(house: house))")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .lineLimit(2)
                                            .padding(.bottom, 5)
                                        
                                        
                                        
                                        let visits = db.getVisitsOfHouse(houseId: house.getId())
                                        if let lastVisit = visits.last {
                                            Text("Last Visit: \(lastVisit.notes)")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .lineLimit(2)
                                                .padding(.bottom, 5)
                                        }
                                        
                                        
                                        
                                    }
                                    .padding(.horizontal, 5)
                                }
                                .padding(15)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                        }
                        //.aspectRatio(contentMode: .fit)
                    }
                    .padding(5)
                }
                
            }
                
            } else {
                Text("No Houses")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .font(.system(size: 36))
            }
            
            
        }
        
        .navigationBarTitle("Territory: \(territory.number)", displayMode: .large)
       
    }
}

func determineLanguage(house: House) -> String{
    switch house.language {
    case "en":
        return "English"
    case "es":
        return "Spanish"
    case "fr":
        return "French"
    default:
        return "\(house.language ?? "No Language")"
    }
}


