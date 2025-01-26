//
//  FavouritesViewController.swift
//  ExchangeMate
//
//  Created by Lena Soroka on 26.01.2025.
//

import UIKit

class FavouritesViewController: UIViewController, Storyboardable, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var favouritesTableView: UITableView!
    @IBOutlet weak var placeholderView: PlaceholderView!
    
    var viewModel: FavouritesViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialUI()
        setupTableView()
        configureActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchAndReloadFavourites()
    }
    
    // MARK: Actions from ViewModel
    private func configureActions() {
        viewModel?.controllerActions.reloadFavourites = { [weak self] in
            self?.reloadFavouritesTableView()
            self?.updateMainUI()
        }
    }
    
    // MARK: - UI Configurations
    private func configureInitialUI() {
        placeholderView.setupUI(for: .favourites)
        updateMainUI()
    }
    
    private func updateMainUI() {
        placeholderView.isHidden = viewModel?.favourites.count != 0
        favouritesTableView.isHidden = viewModel?.favourites.count == 0
    }
    
    // MARK: - TableView
    private func setupTableView() {
        favouritesTableView.register(
            UINib(nibName: CurrencyTableViewCell.cellId, bundle: nil),
            forCellReuseIdentifier: CurrencyTableViewCell.cellId
        )
        favouritesTableView.delegate = self
        favouritesTableView.dataSource = self
        favouritesTableView.delaysContentTouches = false
    }
    
    private func reloadFavouritesTableView() {
        DispatchQueue.main.async {
            self.updateMainUI()
            self.favouritesTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.favourites.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.cellId, for: indexPath) as? CurrencyTableViewCell,
           let currency = viewModel?.favourites[indexPath.row] {
            cell.setup(for: currency) { [weak self] currency in
                self?.viewModel?.toggleFavourite(currency: currency)
            }
            return cell
        }
        return UITableViewCell()
    }
}

