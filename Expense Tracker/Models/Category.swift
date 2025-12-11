//
//  Category.swift
//  Expense Tracker
//
//  Matches Flutter categories for side-by-side parity.
//

import Foundation

enum Category: String, CaseIterable, Codable, Identifiable {
    case food = "Food"
    case transport = "Transport"
    case entertainment = "Entertainment"
    case other = "Other"

    var id: String { rawValue }
}
