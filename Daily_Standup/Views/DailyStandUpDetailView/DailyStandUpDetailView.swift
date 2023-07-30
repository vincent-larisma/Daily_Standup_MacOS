//
//  DailyStandUpDetailView.swift
//  Daily_Standup
//
//  Created by Vincent Angelo Larisma on 7/29/23.
//

import SwiftUI


struct DailyStandUpDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State var dailyStandUpEntry: StandUpEntry
    @State var alertStatus: Bool = false
    @State var alertContext: AlertStructure? = nil
    @State var confirmationShown: Bool = false
    
    var body: some View {
        TextEditor(text: $dailyStandUpEntry.context)
            .font(.system(size: 14, design: .monospaced))
            .toolbar {
                Button("Save") {
                    do {
                        try save()
                    } catch {
                        print(error)
                    }
                }
                
                Button {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(dailyStandUpEntry.context, forType: .string)
                } label: {
                    Image(systemName: "doc.on.doc")
                }
                
                Button {
                   confirmationShown = true
                } label: {
                    Image(systemName: "trash")
                }.confirmationDialog("Are you sure you want to delete this item?", isPresented: $confirmationShown) {
                    Button("Delete", role: .destructive) {
                        do {
                            try delete()
                        } catch {
                            print(error)
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                }

            }
            .alert(isPresented: $alertStatus) {
                if let alertContext = alertContext {
                    return Alert(title: alertContext.title, message: alertContext.message)
                } else {
                    return Alert(title: Text("Unexpected Error"))
                }
            }
    }
    
    private func save() throws -> Void {
        do {
            alertStatus = true
            alertContext = AlertContext.successSavingFile
            try self.viewContext.save()
        } catch {
            print("whoops \(error.localizedDescription)")
        }
    }
    
    private func delete() throws -> Void {
        do {
            alertStatus = true
            alertContext = AlertContext.successDeletingFile
            self.viewContext.delete(dailyStandUpEntry)
            try self.viewContext.save()
        } catch {
            print("whoops \(error.localizedDescription)")
        }
            
    }
}

extension NSTextView {
    open override var frame: CGRect {
        didSet {
            textContainerInset = CGSize(width: 20, height: 20 )
        }
    }
}

struct DailyStandUpDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DailyStandUpDetailView(dailyStandUpEntry: StandUpEntry())
    }
}
