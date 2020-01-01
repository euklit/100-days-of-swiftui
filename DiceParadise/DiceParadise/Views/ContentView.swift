//
//  ContentView.swift
//  DiceParadise
//
//  Created by Niklas Lieven on 27.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        TabView {
            PlayView()
                .tabItem {
                    Image(systemName: "cube")
                    Text("Play")
                }
            HistoryView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("History")
                    
            }
                    
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
