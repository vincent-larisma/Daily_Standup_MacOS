//
//  DailyStandUpViewModel.swift
//  Daily_Standup
//
//  Created by Vincent Angelo Larisma on 7/29/23.
//

import Foundation
import Algorithms
import SwiftUI

final class DailyStandUpViewModel: ObservableObject {
    @Published var selectedDailyStandUp: StandUpEntry? = nil
}
