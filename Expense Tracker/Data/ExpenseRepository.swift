//
//  ExpenseRepository.swift
//  Expense Tracker
//
//  Handles encoding/decoding of expenses to/from UserDefaults.
//  Similar to Flutter's ExpenseRepository.
//

import Foundation

final class ExpenseRepository {
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
    
    func load() -> [Expense] {
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let decoded = try? decoder.decode([Expense].self, from: data)
        else {
            return []
        }
        return decoded
    }
    
    func save(_ expenses: [Expense]) {
        guard let data = try? encoder.encode(expenses) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}

