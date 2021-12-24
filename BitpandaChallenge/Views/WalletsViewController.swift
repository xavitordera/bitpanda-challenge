//
//  WalletsViewController.swift
//  BitpandaChallenge
//
//  Created by Xavier Tordera on 21/12/21.
//

import UIKit

class WalletsViewController: UITableViewController {

    init(viewModel: WalletsViewModel) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let viewModel: WalletsViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Wallets"
        navigationItem.title = "Wallets"
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.register(WalletTableViewCell.self, forCellReuseIdentifier: "WalletTableViewCell")
        tableView.allowsSelection = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch viewModel.sections[section] {
        case .crypto:
            return viewModel.cryptoWallets.count
        case .metal:
            return viewModel.metalWallets.count
        case .fiat:
            return viewModel.fiatWallets.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var wallet: WalletsViewModel.Wallet {
            switch viewModel.sections[indexPath.section] {
            case .crypto:
                return viewModel.cryptoWallets[indexPath.row]
            case .metal:
                return viewModel.metalWallets[indexPath.row]
            case .fiat:
                return viewModel.fiatWallets[indexPath.row]
            }
        }

        if let cell = tableView.dequeueReusableCell(withIdentifier: "WalletTableViewCell", for: indexPath) as? WalletTableViewCell {
            cell.configureCell(wallet: wallet, userInterfaceStyle: traitCollection.userInterfaceStyle)
            return cell
        } else {
            let cell = WalletTableViewCell(style: .default, reuseIdentifier: "WalletTableViewCell")
            cell.configureCell(wallet: wallet, userInterfaceStyle: traitCollection.userInterfaceStyle)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sections[section].sectionTitle
    }
}
