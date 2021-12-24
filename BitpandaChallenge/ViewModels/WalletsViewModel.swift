import Foundation

final class WalletsViewModel {
    internal init(dataAttributes: DataAttributes) {
        self.dataAttributes = dataAttributes
    }
    
    let dataAttributes: DataAttributes

    lazy var cryptoWallets: [Wallet] = {
        dataAttributes.wallets?.compactMap {
            $0.toViewModel(from: dataAttributes, isMetal: false, userInterfaceStyle: .dark)
        } ?? []
    }()

    lazy var metalWallets: [Wallet] = {
        dataAttributes.commodityWallets?.compactMap {
            $0.toViewModel(from: dataAttributes, isMetal: true, userInterfaceStyle: .dark)
        } ?? []
    }()

    lazy var fiatWallets: [Wallet] = {
        dataAttributes.fiatwallets?.compactMap {
            $0.toViewModel(from: dataAttributes, userInterfaceStyle: .dark)
        } ?? []
    }()

    let sections: [Section] = Section.allCases

    enum Section: CaseIterable {
        case crypto, metal, fiat

        var sectionTitle: String {
            switch self {
            case .crypto:
                return "Cryptocurrencies"
            case .metal:
                return "Metals"
            case .fiat:
                return "Fiats"
            }
        }
    }

    struct Wallet {
        let balance: String
        let symbol: String
        let name: String
        let logoURL: URL?
        let isDefault: Bool
        let walletType: WalletType

        enum WalletType {
            case crypto, metal, fiat
        }
    }

}
