//
//  DailyStandUpListView.swift
//  Daily_Standup
//
//  Created by Vincent Angelo Larisma on 7/29/23.
//

import SwiftUI

struct DailyStandUpListView: View {
    let standUp: StandUpEntry
    let isSelected: Bool
    var body: some View {
        HStack{
            if isSelected {
                Label("\(standUp.creationDate.formatted(date: .abbreviated, time: .omitted))", systemImage: "note.text")
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            } else {
                Label("\(standUp.creationDate.formatted(date: .abbreviated, time: .omitted))", systemImage: "note.text")
                    .padding(.horizontal)
                    .padding(.vertical, 5)
            }
           
        }
        .frame(maxWidth: .infinity)
    }
}

struct DailyStandUpListView_Previews: PreviewProvider {
    static var previews: some View {
        DailyStandUpListView(standUp: MockData.sampleMockData.first!, isSelected: false)
    }
}
