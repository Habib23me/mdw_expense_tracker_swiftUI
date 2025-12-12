//
//  AppRouter.swift
//  Expense Tracker
//
//  Centralized navigation routing using NavigationPath.
//

import SwiftUI
import Combine

enum Route: Hashable {
    case addEditView(id: String?)
}
class AppRouter: ObservableObject {
    @Published var path = NavigationPath()

    func go(to: Route) {
        path.append(to)
    }

    func reset() {
        path = NavigationPath()
    }
}
