//
//  CurrencyService.swift
//  Expense Tracker
//
//  Offline converter to mirror Flutter CurrencyService.
//

import Foundation

struct CurrencyService {
    // Approximate offline rates to USD to keep the app self-contained.
    private let toUSD: [Currency: Double] = [
        .usd: 1.0,
        .aed: 0.27,
        .eur: 1.08,
        .gbp: 1.25,
        .inr: 0.012
    ]

    func convert(amount: Double, from: Currency, to: Currency = .usd) -> Double {
        guard let fromRate = toUSD[from], let toRate = toUSD[to], amount >= 0 else {
            return amount
        }
        // Convert the source amount to USD, then to the target currency.
        let usdAmount = amount * fromRate
        return usdAmount / toRate
    }
}
