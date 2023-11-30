//
//  toyProject_TodoListApp.swift
//  toyProject-TodoList
//
//  Created by 김명현 on 11/8/23.
//

import SwiftUI

@main
struct toyProject_TodoListApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
