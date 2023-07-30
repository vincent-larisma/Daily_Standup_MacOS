//
//  DailyStandUpRecord.swift
//  Daily_Standup
//
//  Created by Vincent Angelo Larisma on 7/29/23.
//

import Foundation
import CoreData

final class StandUpEntry: NSManagedObject, Identifiable {
    @NSManaged var context: String
    @NSManaged var creationDate: Date
    @NSManaged var questions: [NSString]
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        setPrimitiveValue(Date.now, forKey: "creationDate")
        setPrimitiveValue(["What did you accomplish since our last check-in?", "What are you working on next?", "Do you have any blockers in the way?"], forKey: "questions")
        var contextResult: String {
                var contextResult = "\(creationDate.formatted(date: .abbreviated, time: .omitted)) \n\n"
                for (index, question) in questions.enumerated() {
                    contextResult += "\(index + 1). \(question) \n - \n\n"
                }
                return contextResult
            }
        setPrimitiveValue(contextResult, forKey: "context")
    }
}

extension StandUpEntry {
    private static var standUpEntryFetchRequest: NSFetchRequest<StandUpEntry> {
        NSFetchRequest(entityName: "StandUpEntry")
    }
    
    static func all() -> NSFetchRequest<StandUpEntry> {
        let request: NSFetchRequest<StandUpEntry> = standUpEntryFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \StandUpEntry.creationDate, ascending: true)
        ]
        return request
    }
}
