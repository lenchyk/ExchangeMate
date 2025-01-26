//
//  CurrenciesViewController.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 23.01.2025.
//

import UIKit

class CurrenciesViewController: UIViewController, Storyboardable, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var currenciesTableView: UITableView!
    @IBOutlet weak var placeholderView: PlaceholderView!
    
    var viewModel: CurrenciesViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialUI()
        setupTableView()
        configureActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchAndReloadLocalCurrencies()
    }
    
    // MARK: - Actions to update UI
    private func configureActions() {
        viewModel?.controllerActions.reloadCurrencies = { [weak self] in
            self?.reloadCurrenciesTableView()
        }
    }
    
    // MARK: - UI Configurations
    private func configureInitialUI() {
        placeholderView.setupUI(for: .currencies)
        updateMainUI()
    }
    
    private func updateMainUI() {
        placeholderView.isHidden = viewModel?.currencies.count != 0
        currenciesTableView.isHidden = viewModel?.currencies.count == 0
    }
    
    // MARK: - TableView
    private func setupTableView() {
        currenciesTableView.register(
            UINib(nibName: CurrencyTableViewCell.cellId, bundle: nil),
            forCellReuseIdentifier: CurrencyTableViewCell.cellId
        )
        currenciesTableView.delegate = self
        currenciesTableView.dataSource = self
        currenciesTableView.delaysContentTouches = false
    }
    
    private func reloadCurrenciesTableView() {
        DispatchQueue.main.async {
            self.updateMainUI()
            self.currenciesTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.currencies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.cellId, for: indexPath) as? CurrencyTableViewCell,
           let currency = viewModel?.currencies[indexPath.row] {
            cell.setup(for: currency) { [weak self] currency in
                self?.viewModel?.toggleFavourite(currency: currency)
            }
            return cell
        }
        return UITableViewCell()
    }
}
