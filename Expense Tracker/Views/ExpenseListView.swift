//
//  ExpenseListView.swift
//  Expense Tracker
//
//  SwiftUI counterpart to Flutter's ExpenseListScreen.
//

import SwiftUI

private enum ExpenseRoute: Hashable {
    case add
    case edit(String)
}

struct ExpenseListView: View {
    @EnvironmentObject private var store: ExpenseStore
    @State private var path: [ExpenseRoute] = []

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
                            Button {
                                path.append(.edit(expense.id))
                            } label: {
                                ExpenseRow(expense: expense)
                            }
                            .buttonStyle(.plain)
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
                        path.append(.add)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationDestination(for: ExpenseRoute.self) { route in
            switch route {
            case .add:
                AddEditExpenseView()
                    .environmentObject(store)
            case .edit(let id):
                AddEditExpenseView(expense: store.expense(withId: id))
                    .environmentObject(store)
            }
        }
    }
}
