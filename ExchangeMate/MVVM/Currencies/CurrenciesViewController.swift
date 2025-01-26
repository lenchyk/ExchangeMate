//
//  CurrenciesViewController.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 23.01.2025.
//

import UIKit

class CurrenciesViewController: UIViewController, Storyboardable, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var currenciesTableView: UITableView!
    @IBOutlet weak var placeholderView: UIView!
    
    var viewModel: CurrenciesViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
        setupTableView()
    }
    
    // MARK: - UI Configurations
    func configureMainUI() {
        placeholderView.isHidden = viewModel?.currencies.count != 0
        currenciesTableView.isHidden = viewModel?.currencies.count == 0
    }
    
    // MARK: - TableView
    func setupTableView() {
        currenciesTableView.register(
            UINib(nibName: CurrencyTableViewCell.cellId, bundle: nil),
            forCellReuseIdentifier: CurrencyTableViewCell.cellId
        )
        currenciesTableView.delegate = self
        currenciesTableView.dataSource = self
        currenciesTableView.delaysContentTouches = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.currencies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.cellId, for: indexPath) as? CurrencyTableViewCell,
           let currency = viewModel?.currencies[indexPath.row] {
            cell.setupUI(for: currency)
            return cell
        }
        return UITableViewCell()
    }
}
