//
//  Constants.swift
//  Stocks
//
//  Created by sokolli on 2/28/23.
//

import Foundation
import UIKit
import SwiftUI

struct Constants {
    // Strings: Log messages
    static let noStocksFound = NSLocalizedString("No Stocks found!", comment: "no schools found")
    
    // URLs
    static let dataUrl = URL(string: "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json")
    static let dataMalformedUrl = URL(string: "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio_malformed.json")
    static let dataEmptyUrl = URL(string: "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio_empty.json")
    
    // Image names
    static let chartIcon = "chart.bar.xaxis"
    static let sliderIcon = "slider.horizontal.3"
    
    // Constraints spacing/padding
    static let cornerRadius: CGFloat = 10
    static let stackViewMargin: CGFloat = 16
    static let barChartPadding: CGFloat = 15
    static let stackViewSpacing: CGFloat = 5
    
    // TableViewCell identifiers
    static let tableViewCellIdentifier = "tableViewCellIdentifier"
    
    // Accessibility identifiers
    static let tableViewIdentifier = "tableView"
    static let stackViewIdentifier = "stackView"
    static let tickerLabelIdentifier = "tickerLabel"
    static let nameLabelIdentifier = "nameLabel"
    static let priceLabelIdentifier = "priceLabel"
    static let dateLabelIdentifier = "dateLabel"
    static let timeLabelIdentifier = "timeLabel"
    static let quantityLabelIdentifier = "quantityLabel"
    static let errorLabelIdentifier = "errorLabel"
    static let activityIndicatorIdentifier = "activityIndicator"
    static let sortButtonIdentifier = "sortButton"
    static let horizontalStackView1Identifier = "horizontalStackView1"
    static let horizontalStackView2Identifier = "horizontalStackView2"
    static let horizontalStackView3Identifier = "horizontalStackView3"
    
    // Heights
    static let sectionHeaderHeight: CGFloat = 36
    
    // Font
    static let extraSmallFontSize: CGFloat = 13
    static let smallFontSize: CGFloat = 15
    static let mediumFontSize: CGFloat = 25
    
    // Strings: text
    static let numberOfSharesText = NSLocalizedString("NUMBER OF SHARES", comment: "number of shares")
    static let chartViewText = NSLocalizedString("Chart View", comment: "chart view")
    static let myPortfolioText = NSLocalizedString("My Portfolio", comment: "my portfolio")
    static let NoStocksInYourPortfolioText = NSLocalizedString("No stocks in your portfolio", comment: "no stocks in your portfolio")
    static let USD = NSLocalizedString("USD", comment: "usd")
    static let sharesText = NSLocalizedString(" shares", comment: "shares")
    static let shareText = NSLocalizedString(" share", comment: "share")
    static let sortByText = NSLocalizedString("Sort By", comment: "sort by")
    static let priceText = NSLocalizedString("Price", comment: "price")
    static let nameText = NSLocalizedString("Name", comment: "name")
    static let quantityText = NSLocalizedString("Quantity", comment: "quantity")
    
    // Strings: Alert related
    static let alertMessage = NSLocalizedString("Couldn't load your portfolio.", comment: "Couldn't load your portfolio.")
    static let ok = NSLocalizedString("Ok", comment: "ok")
    static let cancel = NSLocalizedString("Cancel", comment: "cancel")
    
    // Accessibility
    static let sortButtonAccessibilityLabel = NSLocalizedString("Sort", comment: "accessibility label for sort button")
    static let sortButtonAccessibilityHint = NSLocalizedString("Tap to view sort option", comment: "accessibility hint for sort button")
    static let chartButtonAccessibilityLabel = NSLocalizedString("Chart", comment: "accessibility label for chart button")
    static let chartButtonAccessibilityHint = NSLocalizedString("Tap to view chart", comment: "accessibility hint for chart button")
}
