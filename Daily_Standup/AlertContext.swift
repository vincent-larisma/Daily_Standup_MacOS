//
//  AlertContext.swift
//  Daily_Standup
//
//  Created by Vincent Angelo Larisma on 7/30/23.
//

import Foundation
import SwiftUI

struct AlertStructure {
    let title: Text
    let message: Text
}

struct AlertContext {
    static let successSavingFile = AlertStructure(title: Text("Saved Successfully"), message: Text("Successfully Saved the File"))
    static let successDeletingFile = AlertStructure(title: Text("Deleted Successfully"), message: Text("Successfully Deleted the File"))
}
