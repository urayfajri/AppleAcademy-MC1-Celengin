//
//  CelenginApp.swift
//  Shared
//
//  Created by Uray Muhamad Noor Fajri Widiansyah on 29/03/22.
//

import SwiftUI

@main
struct CelenginApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
