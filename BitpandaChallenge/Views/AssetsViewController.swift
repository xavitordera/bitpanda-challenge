//
//  AssetsViewController.swift
//  BitpandaChallenge
//
//  Created by Xavier Tordera on 21/12/21.
//

import UIKit

class AssetsViewController: UITableViewController {

    private let viewModel: AssetsViewModel
    private let sections: [Sections] = [.list]
    private enum Sections: Int {
        case list
    }
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: AssetsViewModel.Filter.allCases.map {$0.title})
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        control.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .touchUpInside)
        return control
    }()

    init(viewModel: AssetsViewModel) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.register(CommodityTableViewCell.self, forCellReuseIdentifier: "CommodityTableViewCell")
        tableView.allowsSelection = false
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .list:
            switch viewModel.activeFilter {
            case .crypto:
                return viewModel.cryptocoins.count
            case .commodity:
                return viewModel.metals.count
            case .fiat:
                return viewModel.fiats.count
            }
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if sections[section] == .list {
            return segmentedControl
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .list:
            switch viewModel.activeFilter {
            case .crypto:
                return cellForCrypto(tableView, at: indexPath)
            case .commodity:
                return cellForMetal(tableView, at: indexPath)
            case .fiat:
                return cellForFiat(tableView, at: indexPath)
            }
        }
    }

    func cellForCommodity(_ tableView: UITableView, at indexPath: IndexPath) -> CommodityTableViewCell {
        if let commCell = tableView.dequeueReusableCell(withIdentifier: "CommodityTableViewCell", for: indexPath) as? CommodityTableViewCell {
            return commCell
        } else {
            return CommodityTableViewCell.init(style: .default, reuseIdentifier: "CommodityTableViewCell")
        }
    }

    func cellForFiat(_ tableView: UITableView, at indexPath: IndexPath) -> CommodityTableViewCell {
        let cell = cellForCommodity(tableView, at: indexPath)

        cell.configureCell(asset: viewModel.fiats[indexPath.row])

        return cell
    }

    func cellForMetal(_ tableView: UITableView, at indexPath: IndexPath) -> CommodityTableViewCell {
        let cell = cellForCommodity(tableView, at: indexPath)

        cell.configureCell(asset: viewModel.metals[indexPath.row])

        return cell
    }
    func cellForCrypto(_ tableView: UITableView, at indexPath: IndexPath) -> CommodityTableViewCell {
        let cell = cellForCommodity(tableView, at: indexPath)

        cell.configureCell(asset: viewModel.cryptocoins[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel.activeFilter = .crypto
        } else if sender.selectedSegmentIndex == 1 {
            viewModel.activeFilter = .commodity
        } else if sender.selectedSegmentIndex == 2 {
            viewModel.activeFilter = .fiat
        }
        UIView.transition(with: tableView,
                          duration: 0.35,
                          options: .transitionCrossDissolve) { [weak self] in
            self?.tableView.reloadData()
        }
    }

}
