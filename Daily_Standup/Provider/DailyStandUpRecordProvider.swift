//
//  DailyStandUpRecordProvider.swift
//  Daily_Standup
//
//  Created by Vincent Angelo Larisma on 7/29/23.
//

import Foundation
import CoreData

final class DailyStandUpRecordProvider {
    static let shared = DailyStandUpRecordProvider()
    
    private let persistenceContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistenceContainer.viewContext
    }
    
    private init() {
        persistenceContainer = NSPersistentContainer(name: "DailyStandUpDataModel")
        persistenceContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistenceContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load store with error: \(error)")
            }
        }
    }
}
