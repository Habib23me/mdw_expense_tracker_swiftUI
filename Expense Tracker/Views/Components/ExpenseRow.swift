//
//  ExpenseRow.swift
//  Expense Tracker
//
//  SwiftUI row equivalent to Flutter's CupertinoListTile.
//

import SwiftUI

struct ExpenseRow: View {
    let expense: Expense
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(expense.title)
                        .font(.headline)
                    Text(expense.category.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(expense.currency.symbol)\(String(format: "%.2f", expense.amount))")
                        .font(.headline)
                    Text(expense.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(.plain)
    }
}
