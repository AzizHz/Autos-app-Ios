//
//  AutosApp.swift
//  Autos
//
//  Created by iMac on 11/4/2023.
//

import SwiftUI

@main
struct AutosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

