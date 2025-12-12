//
//  ExpenseListView.swift
//  Expense Tracker
//
//  SwiftUI counterpart to Flutter's ExpenseListScreen.
//

import SwiftUI

struct ExpenseListView: View {
    @EnvironmentObject private var store: ExpenseStore
    @EnvironmentObject private var router: AppRouter

    private var total: Double {
        store.expenses.reduce(0) { $0 + $1.amount }
    }

    private var formattedTotal: String {
        String(format: "$%.2f", total)
    }

    var body: some View {
        List {
            if store.expenses.isEmpty {
                Section {
                    Text("No expenses yet")
                        .foregroundStyle(.secondary)
                }
            } else {
                Section {
                    ForEach(store.expenses) { expense in
                        ExpenseRow(
                            expense: expense,
                            onTap: {
                                router.go(to: .addEditView(id: expense.id))
                            }
                        )
                    }
                }
            }

            Section {
                HStack {
                    Text("Total")
                        .font(.headline)
                    Spacer()
                    Text(formattedTotal)
                        .font(.headline.weight(.bold))
                }
            }
        }
        .navigationTitle("Expenses")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    router.go(to: .addEditView(id: nil))
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
