//
//  Stock.swift
//  Stock
//
//  Created by sokolli on 2/28/23.
//

import Foundation

struct Stock: Codable, Identifiable, Equatable {
    var id = UUID()
    let ticker: String
    let name: String
    let currency: String
    let currentPrice: Double
    let quantity: Int?
    let currentPriceTimestamp: Date
    
    init(id: UUID = UUID(), ticker: String, name: String, currency: String, currentPrice: Double, quantity: Int?, currentPriceTimestamp: Date) {
        self.id = id
        self.ticker = ticker
        self.name = name
        self.currency = currency
        self.currentPrice = currentPrice
        self.quantity = quantity
        self.currentPriceTimestamp = currentPriceTimestamp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.ticker = try container.decode(String.self, forKey: .ticker)
        self.name = try container.decode(String.self, forKey: .name)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.quantity = try container.decode(Int?.self, forKey: .quantity)
        self.currentPrice = try container.decode(Double.self, forKey: .currentPrice)/100
        let doubleValue = try container.decode(Double.self, forKey: .currentPriceTimestamp)
        self.currentPriceTimestamp = Date(timeIntervalSince1970: doubleValue)
    }

    func encode(to encoder: Encoder) throws {
    }
}


enum CodingKeys: String, CodingKey {
    case ticker
    case name
    case currency
    case quantity
    case currentPrice = "current_price_cents"
    case currentPriceTimestamp = "current_price_timestamp"
}

extension Date {
    
    func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
    
    func timeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}
