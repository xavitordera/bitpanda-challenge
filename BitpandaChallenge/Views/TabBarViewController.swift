import UIKit
import Combine

class TabBarViewController: UITabBarController {
    private let repository: WelcomeRepositoryProtocol
    private var cancellable: AnyCancellable?
    private var welcomeData: WelcomeViewModels?

    init(repository: WelcomeRepositoryProtocol = WelcomeRepository()) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // show loading state (out of scope)

        cancellable = repository
            .fetchWelcomeData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure = completion {
                    // show an error (out of scope)
                }
            } receiveValue: { [weak self] value in
                self?.welcomeData = value
                self?.setupControllers()
            }
    }

    func setupControllers() {
        guard let welcomeData = welcomeData else { return }
        // Create Tab one
        let tabOne = UINavigationController(rootViewController: AssetsViewController(viewModel: welcomeData.0))
        let tabOneBarItem = UITabBarItem(title: "Assets",
                                         image: UIImage(systemName: "bitcoinsign.circle"),
                                         selectedImage: UIImage(systemName: "bitcoinsign.circle.fill"))

        tabOne.tabBarItem = tabOneBarItem

        // Create Tab two
        let tabTwo = UINavigationController(rootViewController: WalletsViewController(viewModel: welcomeData.1))
        let tabTwoBarItem2 = UITabBarItem(title: "Wallets",
                                          image: UIImage(systemName: "bag"),
                                          selectedImage: UIImage(systemName: "bag.fill"))

        tabTwo.tabBarItem = tabTwoBarItem2


        self.viewControllers = [tabOne, tabTwo]
    }

}

