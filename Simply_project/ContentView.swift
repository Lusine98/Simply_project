//
//  ContentView.swift
//  Simply_project
//
//  Created by Lusine Gasparyan on 11.02.23.
//

import SwiftUI

struct ContentView: View {
    @State private var showRibbon = false
    
    init() {
        UITabBar.appearance().backgroundColor = .white
    }

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                
                VehicleView(completion: {show in
                    showRibbon = show
                })
                    .tabItem {
                        Image(systemName: "car")
                        Text("Vehicle")
                    }
                    .tag(1)
                
                MapView()
                    .tabItem {
                        Image(systemName: "map")
                        Text("Map")
                    }
                    .tag(2)
                SupportView()
                    .tabItem {
                        Image(systemName: "headphones")
                        Text("Support")
                    }
                    .tag(3)
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Settings")
                    }
                    .tag(4)
            }
            .overlay(
                VStack {
                    Spacer()
                    if showRibbon {
                        Rectangle()
                        .foregroundColor(.black)
                        .frame(height: 60)
                        .overlay(
                        HStack {
                            Text("Emergency contact created Successfully")
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .padding(.trailing, 10)
                            })
                            .cornerRadius(5)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .animation(.easeInOut(duration: 5))
                        }
                }
                .padding(.bottom, 60)
                .frame(maxWidth: .infinity))
            .onAppear {
                if(showRibbon) {
                    showRibbon = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        showRibbon = false
                    }
                }
            }
            .navigationBarTitle(Text(self.title), displayMode: .inline)
        }
    }
    
    private var title: String {
        switch self.selectedTab {
            case 0: return "Home"
            case 1: return "Vehicle"
            case 2: return "Map"
            case 3: return "Support"
            case 4: return "Setting"
            default: return ""
            }
        }
    
    @State private var selectedTab = 0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


