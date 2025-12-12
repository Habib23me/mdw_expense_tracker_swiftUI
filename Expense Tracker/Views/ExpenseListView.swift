//
//  ExpenseListView.swift
//  Expense Tracker
//
//  SwiftUI counterpart to Flutter's ExpenseListScreen.
//

import SwiftUI

struct ExpenseListView: View {
    @EnvironmentObject private var store: ExpenseStore
    @State private var path = NavigationPath()

    private var total: Double {
        store.expenses.reduce(0) { $0 + $1.amount }
    }

    private var formattedTotal: String {
        String(format: "$%.2f", total)
    }

    var body: some View {
        NavigationStack(path: $path) {
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
                                    path.append(expense.id)
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
                        path.append(nil)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: String.self) { id in
                AddEditExpenseView(expenseId: id)
                    .environmentObject(store)
            }
        }
    }
}
