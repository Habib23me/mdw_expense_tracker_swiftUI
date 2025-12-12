//
//  ContentView.swift
//  Expense Tracker
//
//  Thin wrapper to mirror Flutter's ExpenseListScreen.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var store: ExpenseStore
    @EnvironmentObject private var router: AppRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ExpenseListView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .addEditView(let id):
                        AddEditExpenseView(expenseId: id)
                            .environmentObject(store)
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ExpenseStore(repository: ExpenseRepository()))
        .environmentObject(AppRouter())
}
