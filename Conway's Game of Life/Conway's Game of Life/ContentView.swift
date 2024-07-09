//
//  ContentView.swift
//  Conway's Game of Life
//
//  Created by Matthew Torres on 9/8/22.
//

import SwiftUI

struct Sim: View{
    var body: some View{
        Text("SIM");
    }
}

struct Config: View{
    var body: some View{
        Text("CONFIG");
    }
}

struct Stats: View{
    var body: some View{
        Text("STATS");
    }
}

struct ContentView: View {
    var body: some View{
    TabView(){
        Sim()
            .tabItem {
                    Label("Simulation", systemImage: "house")
                }
        Config()
            .tabItem {
                    Label("Configuration", systemImage: "books.vertical")
                }
        Stats()
                
                .tabItem {
                    Label("Statistics", systemImage: "books.vertical")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
