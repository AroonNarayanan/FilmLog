//
//  FilmLogApp.swift
//  FilmLog
//
//  Created by Aroon Narayanan on 12/25/21.
//

import SwiftUI

@main
struct FilmLogApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
