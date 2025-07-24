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
    @StateObject var viewModel = MatchViewModel()

    var body: some Scene {
        WindowGroup {
            MatchCardView(viewModel: viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
