//
//  Devote1App.swift
//  Devote1
//
//  Created by Nicolai Bodean on 09.01.2024.
//

import SwiftUI

@main
struct Devote1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
