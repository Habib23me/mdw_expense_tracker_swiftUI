//
//  AddEditExpenseView.swift
//  Expense Tracker
//
//  SwiftUI counterpart to Flutter's AddEditExpenseScreen.
//

import SwiftUI

struct AddEditExpenseView: View {
    @EnvironmentObject private var store: ExpenseStore
    @Environment(\.dismiss) private var dismiss

    private var currencyService = CurrencyService()
    let expenseId: String?

    @State private var title: String = ""
    @State private var amountText: String = ""
    @State private var category: Category = .food
    @State private var currency: Currency = .usd
    
    init(expenseId: String?) {
        self.expenseId = expenseId
    }

    private func loadExistingExpense() {
        expense.flatMap { e in
            title = e.title
            amountText = String(format: "%.2f", e.amount)
            category = e.category
            currency = e.currency
        }
    }

    private var expense: Expense? {
        expenseId.flatMap { store.expense(withId: $0) }
    }

    private var isEditing: Bool { expense != nil }

    private var isSaveDisabled: Bool {
        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || Double(amountText) == nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Title", text: $title)
                        .textInputAutocapitalization(.words)

                    HStack {
                        Text(currency.symbol)
                        TextField("Amount", text: $amountText)
                            .keyboardType(.decimalPad)
                    }

                    Picker("Currency", selection: $currency) {
                        ForEach(Currency.allCases) { currency in
                            Text(currency.rawValue.uppercased())
                                .tag(currency)
                        }
                    }

                    Picker("Category", selection: $category) {
                        ForEach(Category.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }
            }
            .navigationTitle(isEditing ? "Edit Expense" : "Add Expense")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                        .disabled(isSaveDisabled)
                }
            }
            .onAppear(perform: loadExistingExpense)
        }
    }

    private func save() {
        guard let parsedAmount = Double(amountText.trimmingCharacters(in: .whitespacesAndNewlines))
        else {
            return
        }

        // Match the Flutter flow: convert to USD and store as USD.
        let convertedAmount = currencyService.convert(
            amount: parsedAmount,
            from: currency,
            to: .usd
        )

        let newExpense = Expense(
            id: expenseId ?? UUID().uuidString,
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            amount: convertedAmount,
            date: Date(),
            category: category,
            currency: .usd
        )

        store.upsert(newExpense)
        dismiss()
    }
}
