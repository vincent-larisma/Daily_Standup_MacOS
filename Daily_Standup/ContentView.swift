//
//  ContentView.swift
//  Daily_Standup
//
//  Created by Vincent Angelo Larisma on 6/30/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(fetchRequest: StandUpEntry.all()) private var dailyStandUpEntry
    @ObservedObject var viewModel: DailyStandUpViewModel = DailyStandUpViewModel()
    
    var segmentedDailyStandUp: [[StandUpEntry]] {
        let chunkedDailyStandUp = dailyStandUpEntry.chunked{ Calendar.current.isDate($0.creationDate, equalTo: $1.creationDate, toGranularity: .month)}
        return chunkedDailyStandUp.map { Array($0) }
    }
    
    
    var body: some View {
        NavigationSplitView(sidebar: {
            List {
                ForEach(segmentedDailyStandUp, id: \.self){ standUps in
                    DisclosureGroup {
                        ForEach(standUps) { standUp in
                            DailyStandUpListView(standUp: standUp, isSelected: viewModel.selectedDailyStandUp == standUp)
                                .onTapGesture {
                                    viewModel.selectedDailyStandUp = standUp
                                }
                        }
                    } label: {
                        Label(standUps.first?.creationDate.formatted(.dateTime.month(.wide)) ?? "", systemImage: "calendar")
                    }
                    
                }
            }.listStyle(.automatic)
        }, detail: {
            
            if let selectedDailyStandUp = viewModel.selectedDailyStandUp {
                DailyStandUpDetailView(dailyStandUpEntry: selectedDailyStandUp)
                    .id(selectedDailyStandUp.id)
            } else {
                Text("Please select a StandUp")
            }
            
        })
        .frame(minWidth: 400, minHeight: 500)
        .navigationTitle(Text("Daily StandUp"))
        .toolbar {
            ToolbarItem {
                Button {
                    let _ = StandUpEntry(context: viewContext)
                    do {
                        try self.viewContext.save()
                    } catch {
                        print("whoops \(error.localizedDescription)")
                    }
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
