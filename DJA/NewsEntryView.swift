//
//  NewsEntryView.swift
//  DJA
//
//  Created by gio khukhia on 12/21/23.
//

import SwiftUI

struct NewsEntryView: View {
    var entry: NewsEntry

    var body: some View {
        VStack(alignment: .leading) {
            Text(entry.title)
                .font(.headline)
                .foregroundColor(.white)
            Text(entry.description)
                .foregroundColor(.secondary)
            Text(entry.date, style: .date)
                .foregroundColor(.secondary)
        }
        .padding()
        
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.vertical, 5)
    }
}
