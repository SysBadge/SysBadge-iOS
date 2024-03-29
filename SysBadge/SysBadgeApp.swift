//
//  SysBadgeApp.swift
//  SysBadge
//
//  Created by Finn Behrens on 20.10.23.
//

import SwiftUI

@main
struct SysBadgeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        #if os(iOS) || os(macOS)
        DocumentGroup(viewing: SystemDefinitionFile.self) { file in
            SystemFileView(system: file.document.system)
        }
        #endif
    }
}
