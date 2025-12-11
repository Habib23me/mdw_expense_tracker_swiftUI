//
//  Currency.swift
//  Expense Tracker
//
//  Mirrors Flutter currency model and symbol helper.
//

import Foundation

enum Currency: String, CaseIterable, Codable, Identifiable {
    case usd, aed, eur, gbp, inr

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .usd: return "$"
        case .aed: return "AED"
        case .eur: return "€"
        case .gbp: return "£"
        case .inr: return "₹"
        }
    }
}
