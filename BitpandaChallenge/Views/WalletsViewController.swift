//
//  WalletsViewController.swift
//  BitpandaChallenge
//
//  Created by Xavier Tordera on 21/12/21.
//

import UIKit

class WalletsViewController: UITableViewController {

    private lazy var headerView: WalletHeaderView = {
        let view = WalletHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        view.title = viewModel.totalBalance
        return view
    }()

    let viewModel: WalletsViewModel

    init(viewModel: WalletsViewModel) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Wallets"
        navigationItem.title = "Wallets"
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.register(CommodityTableViewCell.self, forCellReuseIdentifier: "CommodityTableViewCell")
        tableView.allowsSelection = false
        tableView.tableHeaderView = headerView
        headerView.setNeedsLayout()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].wallets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: CommodityTableViewCell = {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommodityTableViewCell", for: indexPath) as? CommodityTableViewCell {
                return cell
            } else {
                let cell = CommodityTableViewCell(style: .default, reuseIdentifier: "CommodityTableViewCell")
                return cell
            }
        }()

        cell.configureCell(wallet: viewModel
                            .sections[indexPath.section]
                            .wallets[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sections[section].sectionTitle
    }
}
