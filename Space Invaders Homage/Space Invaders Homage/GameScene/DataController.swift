//
//  DataController.swift
//  Space Invaders Homage
//
//  Created by Mirco Lange on 08.08.24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    var container: NSPersistentContainer
    
    init(name: String) {
        container = NSPersistentContainer(name: name)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("CoreData Error: \(error.localizedDescription)")
            }
        }
    }
}
