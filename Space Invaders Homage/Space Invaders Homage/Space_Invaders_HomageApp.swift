//
//  Space_Invaders_HomageApp.swift
//  Space Invaders Homage
//
//  Created by Michel Matys on 05.08.24.
//

import SwiftUI

@main
struct Space_Invaders_HomageApp: App {
    
    @StateObject private var dataController = DataController(name: "Model")
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
