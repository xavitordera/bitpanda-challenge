import Combine
import Foundation

typealias WelcomeViewModels = (AssetsViewModel, WalletsViewModel)

protocol WelcomeRepositoryProtocol {
    func fetchWelcomeData() -> Future<WelcomeViewModels, Error>
}

struct WelcomeRepository: WelcomeRepositoryProtocol {
    func fetchWelcomeData() -> Future<WelcomeViewModels, Error> {
        Future<WelcomeViewModels, Error> { promise in
            // Here we would fetch from and API or wherever
            if let path = Bundle.main.path(forResource: "Mastrerdata", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    let welcomeData = try decoder.decode(Welcome.self, from: data)

                    guard let attributes = welcomeData.data?.attributes else {
                        promise(.failure(NSError()))
                        return
                    }

                    promise(.success(attributes.toViewModels()))
                } catch(let error) {
                    promise(.failure(error))
                }
            }
        }
    }
}
