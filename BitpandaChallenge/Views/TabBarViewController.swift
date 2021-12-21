//
//  ViewController.swift
//  BitpandaChallenge
//
//  Created by Xavier Tordera on 21/12/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create Tab one
        let tabOne = UINavigationController(rootViewController: AssetsViewController())

        let tabOneBarItem = UITabBarItem(title: "Assets", image: UIImage(systemName: "bitcoinsign.circle"), selectedImage: UIImage(systemName: "bitcoinsign.circle.fill"))

        tabOne.tabBarItem = tabOneBarItem

        // Create Tab two
        let tabTwo = UINavigationController(rootViewController: WalletsViewController())
        let tabTwoBarItem2 = UITabBarItem(title: "Wallets", image: UIImage(systemName: "bag"), selectedImage: UIImage(systemName: "bag.fill"))

        tabTwo.tabBarItem = tabTwoBarItem2


        self.viewControllers = [tabOne, tabTwo]
    }


}

