//
//  SplashViewController.swift
//  BitpandaChallenge
//
//  Created by Xavier Tordera on 22/12/21.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigationController?.pushViewController(TabBarViewController(), animated: true)
        }
    }
}
