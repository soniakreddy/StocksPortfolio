//
//  ViewControllerTests.swift
//  StocksTests
//
//  Created by sokolli on 2/28/23.
//

import XCTest

final class ViewControllerTests: XCTestCase {
    private var viewController = ViewController()
    
    override func setUp() {
        super.setUp()
        viewController.stocks = stocksData.stocks
        viewController.view.layoutSubviews()
    }
    
    func testTableViewNumberOfRows() throws {
        XCTAssertNil(errorLabel.text)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 10)
    }
    
    func testErrorLabel() throws {
        XCTAssertNil(errorLabel.text)
        XCTAssertFalse(tableView.isHidden)
        
        viewController.stocks = []
        viewController.viewWillAppear(true)
        
        XCTAssertEqual(errorLabel.text, Constants.NoStocksInYourPortfolioText)
        XCTAssertTrue(tableView.isHidden)
    }
    
    func testNavigationBarTitle() throws {
        XCTAssertEqual(viewController.title, Constants.myPortfolioText)
        
        tableView.scrollToRow(at: IndexPath(row: 6, section: 0), at: .top, animated: true)
        XCTAssertEqual(viewController.title, "Total: $282,239.96")
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
        XCTAssertEqual(viewController.title, Constants.myPortfolioText)
    }
}

extension ViewControllerTests {
    var tableView: UITableView! {
        return viewController.view.viewWithAccessibilityIdentifier(Constants.tableViewIdentifier, classType: UITableView.self)!
    }

    var errorLabel: UILabel! {
        return viewController.view.viewWithAccessibilityIdentifier(Constants.errorLabelIdentifier, classType: UILabel.self)!
    }
    
    var activityIndicator: UIActivityIndicatorView! {
        return viewController.view.viewWithAccessibilityIdentifier(Constants.activityIndicatorIdentifier, classType: UIActivityIndicatorView.self)!
    }
}

extension UIBarButtonItem {
    public func simulateTouch() {
        if let button = customView as? UIButton {
            button.sendActions(for: .touchUpInside)
        } else {
            UIApplication.shared.sendAction(action!, to: target, from: nil, for: nil)
        }
    }
}
