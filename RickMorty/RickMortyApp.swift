//
//  RickMortyApp.swift
//  RickMorty
//
//  Created by Zulqarnain Naveed Macbook on 25/08/2024.
//

import SwiftUI

@main
struct RickMortyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
