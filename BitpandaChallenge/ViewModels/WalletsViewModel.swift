import Foundation

final class WalletsViewModel {

    private let cryptoWallets: [Wallet]
    private let metalWallets: [Wallet]
    private let fiatWallets: [Wallet]

    let title = "wallets".localized

    lazy var totalBalance: String? = {
        var accumlatedBalance = 0.0
        cryptoWallets.forEach { accumlatedBalance += $0.eurBalance }
        metalWallets.forEach { accumlatedBalance += $0.eurBalance }
        fiatWallets.forEach { accumlatedBalance += $0.eurBalance }
        return String(accumlatedBalance).formattedPrice(precision: 2)
    }()

    lazy var sections: [Section] = [
        .crypto(cryptoWallets),
        .metal(metalWallets),
        .fiat(fiatWallets)
    ]

    init(cryptoWallets: [WalletsViewModel.Wallet],
         metalWallets: [WalletsViewModel.Wallet],
         fiatWallets: [WalletsViewModel.Wallet]) {
       self.cryptoWallets = cryptoWallets
       self.metalWallets = metalWallets
       self.fiatWallets = fiatWallets
   }

    enum Section {
        case crypto([Wallet]), metal([Wallet]), fiat([Wallet])

        var sectionTitle: String {
            switch self {
            case .crypto:
                return "crypto".localized
            case .metal:
                return "metals".localized
            case .fiat:
                return "fiats".localized
            }
        }

        var wallets: [Wallet] {
            switch self {
            case .crypto(let wallets), .metal(let wallets), .fiat(let wallets):
                return wallets
            }
        }
    }

    struct Wallet {
        let eurBalance: Double
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
