//
//  NewsEntry.swift
//  DJA
//
//  Created by gio khukhia on 12/21/23.
//

import Foundation

struct NewsEntry: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var description: String
    var date: Date
}
