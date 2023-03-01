//
//  ViewController.swift
//  Stocks
//
//  Created by sokolli on 2/28/23.
//

import UIKit

class ViewController: UIViewController {
    var stocks: [Stock]?
    private var totalValueString = ""
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = Constants.tableViewIdentifier
        tableView.layer.cornerRadius = Constants.cornerRadius
        tableView.register(StockInfoTableViewCell.self, forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        tableView.backgroundColor = .navyBlueColor
        tableView.separatorColor = .white
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = Constants.errorLabelIdentifier
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: Constants.mediumFontSize, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.accessibilityIdentifier = Constants.activityIndicatorIdentifier
        activityIndicator.color = .white
        return activityIndicator
    }()
    
    private lazy var sortButton: UIBarButtonItem = {
        let sortButton = UIBarButtonItem(image: UIImage(systemName: Constants.sliderIcon), style: .plain, target: self, action: #selector(sortButtonTapped))
        sortButton.accessibilityIdentifier = Constants.sortButtonIdentifier
        sortButton.accessibilityLabel = Constants.sortButtonAccessibilityLabel
        sortButton.accessibilityHint = Constants.sortButtonAccessibilityHint
        sortButton.tintColor = .mustardYellowColor
        return sortButton
    }()
    
    private lazy var chartButton: UIBarButtonItem = {
        let chartButton = UIBarButtonItem(image: UIImage(systemName: Constants.chartIcon), style: .plain, target: self, action: #selector(chartButtonTapped))
        chartButton.accessibilityLabel = Constants.chartButtonAccessibilityLabel
        chartButton.accessibilityHint = Constants.chartButtonAccessibilityHint
        chartButton.tintColor = .brightRedColor
        return chartButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        view.addSubview(activityIndicator)
        
        view.backgroundColor = .navyBlueColor
        
        configureNavigationBar()
        addConstraints()
        performNetworkCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateViewIfStocksAreEmpty()
    }
    
    private func configureNavigationBar() {
        title = Constants.myPortfolioText
        navigationItem.rightBarButtonItem = sortButton
        navigationItem.leftBarButtonItem = chartButton
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  UIColor.white]
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backgroundColor = .navyBlueColor
        navigationController?.navigationBar.barTintColor = .navyBlueColor
    }
    
    private func addConstraints() {
        var customConstraints = [NSLayoutConstraint]()
        customConstraints.append(errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        customConstraints.append(errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        customConstraints.append(activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        customConstraints.append(activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        customConstraints.append(tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        customConstraints.append(tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        customConstraints.append(tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        customConstraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        NSLayoutConstraint.activate(customConstraints)
    }
    
    private func performNetworkCall() {
        activityIndicator.startAnimating()
        NetworkManager.shared.fetchData { [weak self] (stocksData, error) in
            guard let self = self else { return }
            
            if let stocksData = stocksData {
                self.stocks = stocksData.stocks.sorted(by: { $0.name < $1.name })
                self.calculateTotal()
                DispatchQueue.main.async {
                    self.updateViewIfStocksAreEmpty()
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    let alert = UIAlertController(title: "", message:Constants.alertMessage, preferredStyle: .alert)
                    let okAction =  UIAlertAction(title: Constants.ok, style: .cancel, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                print(Constants.noStocksFound)
            }
        }
    }
    
    private func calculateTotal() {
        var value = 0.0
        if let stocks = stocks {
            value = stocks.map{ $0.currentPrice * Double($0.quantity ?? 0) }.reduce(0, +)
        }
        totalValueString = value.formatted(.currency(code: Constants.USD))
    }
    
    private func updateViewIfStocksAreEmpty() {
        if let stocks = stocks, stocks.count == 0 {
            tableView.isHidden = true
            errorLabel.text = Constants.NoStocksInYourPortfolioText
        }
    }
    
    @objc private func chartButtonTapped(_ sender: UIButton) {
        guard let stocks = stocks else { return }
        let chartViewController = ChartViewController(stocks: stocks)
        navigationController?.pushViewController(chartViewController, animated: true)
    }
    
    @objc private func sortButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: Constants.sortByText, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: Constants.nameText, style: .default, handler: { action in
            self.stocks = self.stocks?.sorted(by: { $0.name < $1.name })
            self.tableView.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: Constants.priceText, style: .default, handler: { action in
            self.stocks = self.stocks?.sorted(by: { $0.currentPrice < $1.currentPrice })
            self.tableView.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: Constants.quantityText, style: .default, handler: { action in
            self.stocks = self.stocks?.sorted(by: { $0.quantity ?? 0 < $1.quantity ?? 0 })
            self.tableView.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: Constants.cancel, style: .cancel))
        alertController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(alertController, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let stocks = stocks else { return UITableViewCell() }
        let cell: StockInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier)  as! StockInfoTableViewCell
        cell.configureCell(stocks[indexPath.row])
        return cell
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        calculateTotal()
        title = scrollView.contentOffset.y <= 10 ? Constants.myPortfolioText : "Total: \(totalValueString)"
    }
}
