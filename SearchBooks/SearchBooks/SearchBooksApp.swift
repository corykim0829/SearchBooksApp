//
//  SearchBooksApp.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/10/24.
//

import SwiftUI

@main
struct SearchBooksApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
