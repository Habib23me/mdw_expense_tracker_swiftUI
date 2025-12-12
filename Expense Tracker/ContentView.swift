//
//  ContentView.swift
//  Expense Tracker
//
//  Thin wrapper to mirror Flutter's ExpenseListScreen.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ExpenseListView()
    }
}

#Preview {
    ContentView()
        .environmentObject(ExpenseStore(repository: ExpenseRepository()))
}
