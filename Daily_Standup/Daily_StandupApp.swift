//
//  Daily_StandupApp.swift
//  Daily_Standup
//
//  Created by Vincent Angelo Larisma on 6/30/23.
//

import SwiftUI

@main
struct Daily_StandupApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, DailyStandUpRecordProvider.shared.viewContext)
        }
    }
}
