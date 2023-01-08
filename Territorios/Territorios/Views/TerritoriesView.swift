//
//  TerritoriesView.swift
//  Territorios
//
//  Created by Jose Blanco on 1/2/23.
//

import Foundation
import SwiftUI

struct TerritoriesView: View{
    @ObservedObject var db = DataBaseManager()
    
    
    
    @StateObject var state = StartupManager()
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.scenePhase) var scenePhase
    
    @State var toggleOn =  false
    
    
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        let territories = db.territories.sorted {
            Int(exactly: $0.number)! < Int(exactly: $1.number)!
        }
        
        NavigationStack{
            
            ScrollView{
                VStack {
                    ForEach(territories, id: \.self.number) { territory in
                        NavigationLink(destination: HousesView(territory: territory, toggleOn: toggleOn)){
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
                                            Text("\(territory.number)")
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(.white)
                                            
                                        }
                                    }
                                    .frame(width: 70, height: 70, alignment: .center)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Territory \(territory.number)")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .lineLimit(2)
                                            .padding(.bottom, 5)
                                        
                                        Text(territory.address)
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
                            
                        }
                        //.aspectRatio(contentMode: .fit)
                    }
                    .padding(2)
                }
            }
            
            .navigationBarTitle("Territories", displayMode: .large)
            .navigationBarItems(leading:
            VStack{
                HStack {
                    ZStack {
                        Capsule()
                            .frame(width:70,height:34)
                            .foregroundColor(.primary)
                        ZStack{
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.blue, .teal]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width:30, height:30)
                            //.foregroundColor(.white)
                            Image(systemName: toggleOn ? "phone" : "house")
                                .scaledToFit()
                                .padding(5)
                                .foregroundColor(.white)
                            
                        }
                        .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
                        .offset(x:toggleOn ? 18 : -18)
                        //.padding(24)
                        .animation(Animation.spring())
                    }
                    Text("Mode")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                //.padding(.bottom, 5)
                //Text("Preaching Mode")
            }
                                
                .onTapGesture {
                    self.toggleOn.toggle()
                    
                })
            
            
        }
        
    }
    
}

struct TerritoriesView_Previews: PreviewProvider {
    static var previews: some View {
        TerritoriesView()
        
    }
}
