//
//  EditNewsView.swift
//  DJA
//
//  Created by gio khukhia on 12/21/23.
//
import SwiftUI

struct EditNewsView: View {
    @Binding var newsEntry: NewsEntry
    let onSave: () -> Void
    let onCancel: () -> Void

    var body: some View {
        Form {
            Section(header: Text("Edit News")) {
                TextField("Title", text: $newsEntry.title)
                TextEditor(text: $newsEntry.description)
                DatePicker("Date", selection: $newsEntry.date, displayedComponents: .date)
            }

            Section {
                Button("Save") {
                    onSave()
                }
                .foregroundColor(.white)
                .background(Color.purple)
                .cornerRadius(10)
            }
        }
        .navigationBarItems(trailing: Button("Cancel") {
            onCancel()
        })
    }
}
