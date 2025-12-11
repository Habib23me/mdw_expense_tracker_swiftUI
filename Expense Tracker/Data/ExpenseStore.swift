//
//  ExpenseStore.swift
//  Expense Tracker
//
//  Local persistence using UserDefaults (Flutter equivalent: SharedPreferences).
//

import Foundation

@MainActor
final class ExpenseStore: ObservableObject {
    @Published private(set) var expenses: [Expense] = []

    private let storageKey = "expenses"
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    init() {
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
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let decoded = try? decoder.decode([Expense].self, from: data)
        else {
            expenses = []
            return
        }
        expenses = decoded
    }

    private func save() {
        guard let data = try? encoder.encode(expenses) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}
