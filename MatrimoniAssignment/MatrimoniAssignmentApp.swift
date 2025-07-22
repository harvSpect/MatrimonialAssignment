//
//  MatrimoniAssignmentApp.swift
//  MatrimoniAssignment
//
//  Created by Yadnyesh Khakal on 22/07/25.
//

import SwiftUI

@main
struct MatrimoniAssignmentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
