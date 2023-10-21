//
//  ContentView.swift
//  SysBadge
//
//  Created by Finn Behrens on 20.10.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FileMainView()
                .tabItem {
                    Label("File", systemImage: "folder.badge.person.crop")
                }
        }
    }
}

#Preview {
    ContentView()
}
