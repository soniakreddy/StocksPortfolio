//
//  StockInfoTableViewCellTests.swift
//  Stocks
//
//  Created by sokolli on 2/28/23.
//

import XCTest

final class StockInfoTableViewCellTests: XCTestCase {
    private var cell = StockInfoTableViewCell()
    
    override func setUp() {
        super.setUp()
    }
    
    func testCellConfigurationWithEmptyQuantity() throws {
        let stock = Stock(ticker: "BAC",
                          name: "Bank of America Corporation",
                          currency: Constants.USD,
                          currentPrice: 23.93,
                          quantity: nil,
                          currentPriceTimestamp: .now)
        cell.configureCell(stock)
        XCTAssertEqual(tickerLabel.text, "BAC")
        XCTAssertEqual(nameLabel.text, "Bank of America Corporation")
        XCTAssertEqual(priceLabel.text, "$23.93")
        XCTAssertEqual(dateLabel.text, Date.now.dateString())
        XCTAssertEqual(timeLabel.text, Date.now.timeString())
        XCTAssertEqual(quantityLabel.text, "0 share")
    }
    
    func testCellConfigurationWithOneQuantity() throws {
        let stock = Stock(ticker: "BAC",
                          name: "Bank of America Corporation",
                          currency: Constants.USD,
                          currentPrice: 23.93,
                          quantity: 1,
                          currentPriceTimestamp: .now)
        cell.configureCell(stock)
        XCTAssertEqual(tickerLabel.text, "BAC")
        XCTAssertEqual(nameLabel.text, "Bank of America Corporation")
        XCTAssertEqual(priceLabel.text, "$23.93")
        XCTAssertEqual(dateLabel.text, Date.now.dateString())
        XCTAssertEqual(timeLabel.text, Date.now.timeString())
        XCTAssertEqual(quantityLabel.text, "1 share")
    }
    
    func testCellConfigurationWithMultipleQuantities() throws {
        let stock = Stock(ticker: "BAC",
                          name: "Bank of America Corporation",
                          currency: Constants.USD,
                          currentPrice: 23.93,
                          quantity: 25,
                          currentPriceTimestamp: .now)
        cell.configureCell(stock)
        XCTAssertEqual(tickerLabel.text, "BAC")
        XCTAssertEqual(nameLabel.text, "Bank of America Corporation")
        XCTAssertEqual(priceLabel.text, "$23.93")
        XCTAssertEqual(dateLabel.text, Date.now.dateString())
        XCTAssertEqual(timeLabel.text, Date.now.timeString())
        XCTAssertEqual(quantityLabel.text, "25 shares")
    }
}

extension StockInfoTableViewCellTests {
    var tickerLabel: UILabel! {
        return cell.viewWithAccessibilityIdentifier(Constants.tickerLabelIdentifier, classType: UILabel.self)!
    }

    var nameLabel: UILabel! {
        return cell.viewWithAccessibilityIdentifier(Constants.nameLabelIdentifier, classType: UILabel.self)!
    }
    
    var priceLabel: UILabel! {
        return cell.viewWithAccessibilityIdentifier(Constants.priceLabelIdentifier, classType: UILabel.self)!
    }
    
    var dateLabel: UILabel! {
        return cell.viewWithAccessibilityIdentifier(Constants.dateLabelIdentifier, classType: UILabel.self)!
    }
    
    var timeLabel: UILabel! {
        return cell.viewWithAccessibilityIdentifier(Constants.timeLabelIdentifier, classType: UILabel.self)!
    }
    
    var quantityLabel: UILabel! {
        return cell.viewWithAccessibilityIdentifier(Constants.quantityLabelIdentifier, classType: UILabel.self)!
    }
}

extension UIView {
    @nonobjc public func viewWithAccessibilityIdentifier(_ accessibilityIdentifier: String) -> UIView? {
        return viewWithAccessibilityIdentifier(accessibilityIdentifier, classType: UIView.self)
    }
    
    @nonobjc public func viewWithAccessibilityIdentifier<T: UIView>(_ accessibilityIdentifier: String, classType: T.Type) -> T? {
        if let selfObject = self as? T, self.accessibilityIdentifier == accessibilityIdentifier {
            return selfObject
        }
        
        for subview in self.subviews {
            if let match = subview.viewWithAccessibilityIdentifier(accessibilityIdentifier, classType: classType) {
                return match
            }
        }
        
        return nil
    }
}
