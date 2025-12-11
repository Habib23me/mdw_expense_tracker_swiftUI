//
//  Expense_TrackerApp.swift
//  Expense Tracker
//
//  Created by Habib Mohammed on 09/12/2025.
//

import SwiftUI

@main
struct Expense_TrackerApp: App {
    @StateObject private var store = ExpenseStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
