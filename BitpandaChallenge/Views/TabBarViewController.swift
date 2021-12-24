//
//  ViewController.swift
//  BitpandaChallenge
//
//  Created by Xavier Tordera on 21/12/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    lazy var data: Welcome? = {
        if let path = Bundle.main.path(forResource: "Mastrerdata", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let jsonPetitions = try decoder.decode(Welcome.self, from: data)
                return jsonPetitions
            } catch(let error) {
                debugPrint(error)
                return nil
            }
        }
        return nil
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let att = data?.data?.attributes else { return }
        // Create Tab one
        let tabOne = UINavigationController(rootViewController: AssetsViewController(viewModel: AssetsViewModel(attributes: att)))
        let tabOneBarItem = UITabBarItem(title: "Assets",
                                         image: UIImage(systemName: "bitcoinsign.circle"),
                                         selectedImage: UIImage(systemName: "bitcoinsign.circle.fill"))

        tabOne.tabBarItem = tabOneBarItem

        // Create Tab two
        let tabTwo = UINavigationController(rootViewController: WalletsViewController(viewModel: WalletsViewModel(dataAttributes: att)))
        let tabTwoBarItem2 = UITabBarItem(title: "Wallets",
                                          image: UIImage(systemName: "bag"),
                                          selectedImage: UIImage(systemName: "bag.fill"))

        tabTwo.tabBarItem = tabTwoBarItem2


        self.viewControllers = [tabOne, tabTwo]
    }

}

