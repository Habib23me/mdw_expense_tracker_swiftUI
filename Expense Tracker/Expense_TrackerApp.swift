//
//  Expense_TrackerApp.swift
//  Expense Tracker
//
//  Created by Habib Mohammed on 09/12/2025.
//

import SwiftUI
@main
struct Expense_TrackerApp: App {
    @StateObject private var store: ExpenseStore
    @StateObject private var router = AppRouter()
    
    init() {
        let repository = ExpenseRepository()
        _store = StateObject(wrappedValue: ExpenseStore(repository: repository))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .environmentObject(router)
        }
    }
}
