//
//  StockInfoTableViewCell.swift
//  Stocks
//
//  Created by sokolli on 2/28/23.
//

import Foundation
import UIKit

class StockInfoTableViewCell: UITableViewCell {
    private var customConstraints = [NSLayoutConstraint]()
    
    private lazy var tickerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.systemFont(ofSize: Constants.mediumFontSize, weight: .semibold)
        label.accessibilityIdentifier = Constants.tickerLabelIdentifier
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.textColor = .white
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = Constants.nameLabelIdentifier
        label.font = UIFont.systemFont(ofSize: Constants.smallFontSize, weight: .light)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.textColor = .lightText
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = Constants.priceLabelIdentifier
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = .white
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = Constants.dateLabelIdentifier
        label.font = UIFont.systemFont(ofSize: Constants.extraSmallFontSize, weight: .regular)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = Constants.timeLabelIdentifier
        label.font = UIFont.systemFont(ofSize: Constants.extraSmallFontSize, weight: .regular)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = Constants.quantityLabelIdentifier
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: Constants.extraSmallFontSize, weight: .medium)
        label.textColor = .mustardYellowColor
        return label
    }()
    
    private lazy var horizontalStackView1: UIStackView = {
        let view = UIStackView(arrangedSubviews: [tickerLabel, priceLabel])
        view.accessibilityIdentifier = Constants.horizontalStackView1Identifier
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = Constants.stackViewSpacing
        view.distribution = .fill
        return view
    }()
    
    private lazy var horizontalStackView2: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel, dateLabel])
        view.accessibilityIdentifier = Constants.horizontalStackView2Identifier
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = Constants.stackViewSpacing
        view.distribution = .fill
        return view
    }()
    
    private lazy var horizontalStackView3: UIStackView = {
        let view = UIStackView(arrangedSubviews: [quantityLabel, timeLabel])
        view.accessibilityIdentifier = Constants.horizontalStackView3Identifier
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = Constants.stackViewSpacing
        view.distribution = .fill
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [horizontalStackView1, horizontalStackView2, horizontalStackView3])
        view.accessibilityIdentifier = Constants.stackViewIdentifier
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = Constants.stackViewSpacing
        view.distribution = .fill
        return view
    }()
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        layoutMargins = .zero
        contentView.backgroundColor = .navyBlueColor
        
        contentView.addSubview(stackView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func updateConstraints() {
        defer { super.updateConstraints() }
        guard customConstraints.isEmpty else { return }
        
        let views = [
            "stackView": stackView
        ]
        
        let metrics = [
            "stackViewMargin": Constants.stackViewMargin
        ]
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-(stackViewMargin)-[stackView]-(stackViewMargin)-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(stackViewMargin)-[stackView]-(stackViewMargin)-|", metrics: metrics, views: views))
        
        NSLayoutConstraint.activate(customConstraints)
    }
    
    func configureCell(_ stock: Stock) {
        tickerLabel.text = stock.ticker
        nameLabel.text = stock.name
        priceLabel.text = stock.currentPrice.formatted(.currency(code: stock.currency))
        timeLabel.text = stock.currentPriceTimestamp.timeString()
        dateLabel.text = stock.currentPriceTimestamp.dateString()
        let shareQuantityText = stock.quantity ?? 0 > 1 ? Constants.sharesText : Constants.shareText
        quantityLabel.text = (stock.quantity?.codingKey.stringValue ?? "0") + shareQuantityText
    }
}
