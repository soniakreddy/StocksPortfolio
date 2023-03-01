//
//  ChartViewController.swift
//  Stocks
//
//  Created by sokolli on 2/28/23.
//

import Foundation
import UIKit
import SwiftUI

class ChartViewController: UIViewController {
    let barChartViewController: UIViewController

    init(stocks: [Stock]) {
        let stocksData = stocks.sorted(by: { $0.quantity ?? 0 < $1.quantity ?? 0 })
        self.barChartViewController = UIHostingController(rootView: BarChart(stocks: stocksData))
        super.init(nibName: nil, bundle: nil)
        navigationController?.isNavigationBarHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(barChartViewController)
        view.addSubview(barChartViewController.view)
        view.backgroundColor = .navyBlueColor
        
        configureNavigationBar()
        addConstraints()
    }

    private func configureNavigationBar() {
        title = Constants.chartViewText
        navigationController?.navigationBar.backgroundColor = .navyBlueColor
        navigationController?.navigationBar.tintColor = .lightText
    }
    
    private func addConstraints() {
        var customConstraints = [NSLayoutConstraint]()
        barChartViewController.view.translatesAutoresizingMaskIntoConstraints = false
        customConstraints.append(barChartViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.barChartPadding))
        customConstraints.append(barChartViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.barChartPadding))
        customConstraints.append(barChartViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.barChartPadding))
        customConstraints.append(barChartViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.barChartPadding))
        NSLayoutConstraint.activate(customConstraints)
    }
}
