//
//  ContentView.swift
//  HealthCare
//
//  Created by Kimura on 2024/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = 3
    
    var body: some View {
        TabView(selection: $selection) {
            ExerciseRecordView()
                .tabItem {
                    Label("Exercise",systemImage: "figure.run")
                }
                .tag(1)
            FoodRecordView()
                .tabItem {
                    Label("Food",systemImage: "fork.knife")
                }
                .tag(2)
            HomeView()
                .tabItem {
                    Label("Home",systemImage: "house.fill")
                }
                .tag(3)
            WeightManagementView()
                .tabItem {
                    Label("Weight",systemImage: "scalemass.fill")
                }
                .tag(4)
            SettingView()
                .tabItem {
                    Label("Setting",systemImage: "gearshape")
                }
                .tag(5)
        }
    }
}

#Preview {
    ContentView()
}
