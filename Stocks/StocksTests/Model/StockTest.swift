//
//  StockTest.swift
//  StocksTests
//
//  Created by sokolli on 2/28/23.
//

import XCTest

final class StockTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testStock() throws {
        let json = "{\"ticker\":\"TWTR\",\"name\":\"Twitter, Inc.\",\"currency\":\"USD\",\"current_price_cents\" :3833,\"quantity\":null,\"current_price_timestamp\":1636657688}"
        let date = Date(timeIntervalSince1970: Double(1636657688))
        try verifyRoundTrip(json: json, expectedNode: Stock(ticker: "TWTR", name: "Twitter, Inc.", currency: Constants.USD, currentPrice: 38.33, quantity: nil, currentPriceTimestamp: date))
    }
    
    func testIncorrectJson() {
        let badJson = "notJson { }"
        XCTAssertThrowsError(try decode(json: badJson))
    }
    
    private func verifyRoundTrip(json: String, expectedNode: Stock) throws {
        let node = try decode(json: json)
        XCTAssertEqual(node.ticker, expectedNode.ticker)
        XCTAssertEqual(node.name, expectedNode.name)
        XCTAssertEqual(node.currency, expectedNode.currency)
        XCTAssertEqual(node.currentPrice, expectedNode.currentPrice)
        XCTAssertEqual(node.quantity, expectedNode.quantity)
        XCTAssertEqual(node.currentPriceTimestamp, expectedNode.currentPriceTimestamp)
    }
    
    private func decode(json: String) throws -> Stock {
        let decoder = JSONDecoder()
        let data = Data(json.utf8)
        let node = try decoder.decode(Stock.self, from: data)
        return node
    }
}
