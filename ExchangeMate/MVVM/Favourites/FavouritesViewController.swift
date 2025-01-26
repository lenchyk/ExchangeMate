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
        configureMainUI()
        setupTableView()
    }
    
    // MARK: - UI Configurations
    private func configureMainUI() {
        placeholderView.setupUI(for: .favourites)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.favourites.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.cellId, for: indexPath) as? CurrencyTableViewCell,
           let currency = viewModel?.favourites[indexPath.row] {
            cell.setup(for: currency) { [weak self] currency in
                self?.viewModel?.removeFromFavourites(currency: currency)
            }
            return cell
        }
        return UITableViewCell()
    }
}

