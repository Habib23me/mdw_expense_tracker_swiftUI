//
//  ExpenseStore.swift
//  Expense Tracker
//
//  State management for expenses, using ExpenseRepository for persistence.
//

import Foundation
import Combine

@MainActor
final class ExpenseStore: ObservableObject {
    @Published private(set) var expenses: [Expense] = []
    
    private let repository: ExpenseRepository
    
    init(repository: ExpenseRepository) {
        self.repository = repository
        load()
    }

    func expense(withId id: String) -> Expense? {
        expenses.first(where: { $0.id == id })
    }

    func upsert(_ expense: Expense) {
        if let index = expenses.firstIndex(where: { $0.id == expense.id }) {
            expenses[index] = expense
        } else {
            expenses.append(expense)
        }
        expenses.sort { $0.date > $1.date }
        save()
    }

    private func load() {
        expenses = repository.load()
    }

    private func save() {
        repository.save(expenses)
    }
}
