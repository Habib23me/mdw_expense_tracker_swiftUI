//
//  Expense.swift
//  Expense Tracker
//
//  SwiftUI equivalent of the Flutter Expense model.
//

import Foundation

struct Expense: Identifiable, Codable, Equatable {
    let id: String
    var title: String
    var amount: Double
    var date: Date
    var category: Category
    var currency: Currency
}
