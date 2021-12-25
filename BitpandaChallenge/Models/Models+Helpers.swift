import Foundation
import UIKit

extension Commodity {
    func logoImageURL(userInterfaceStyle: UIUserInterfaceStyle = UIScreen.main.traitCollection.userInterfaceStyle) -> URL? {
        if userInterfaceStyle == .dark {
            return URL(string: attributes?.logoDark ?? "")
        } else {
            return URL(string: attributes?.logo ?? "")
        }
    }

    func toViewModel(isMetal: Bool) -> AssetsViewModel.Asset {
        AssetsViewModel.Asset(title: attributes?.name ?? "",
                              price: attributes?.avgPrice?.formattedPrice(precision: attributes?.precisionForFiatPrice ?? 2) ?? "",
                              logoURL: logoImageURL(),
                              type: isMetal ? .metal : .crypto)
    }
}

extension Fiat {
    func logoImageURL(userInterfaceStyle: UIUserInterfaceStyle = UIScreen.main.traitCollection.userInterfaceStyle) -> URL? {
        if userInterfaceStyle == .dark {
            return URL(string: attributes?.logoDark ?? "")
        } else {
            return URL(string: attributes?.logo ?? "")
        }
    }

    func toViewModel() -> AssetsViewModel.Asset? {
        guard (attributes?.hasWallets ?? false) else {
            return nil
        }
        return AssetsViewModel.Asset(title: attributes?.name ?? "",
                                     price: attributes?.symbol ?? "",
                                     logoURL: logoImageURL(), type: .fiat)
    }
}

extension DataAttributes {
    func getFiatWithId(_ id: String) -> Fiat? {
        fiats?.filter { $0.id == id }.first
    }

    func getCryptoWithId(_ id: String) -> Commodity? {
        cryptocoins?.filter { $0.id == id }.first
    }

    func getCommodityWithId(_ id: String) -> Commodity? {
        commodities?.filter { $0.id == id }.first
    }

    func toViewModels() -> WelcomeViewModels {

        // AssetsViewModel
        let cryptoAssets: [AssetsViewModel.Asset] = cryptocoins?.compactMap {
            $0.toViewModel(isMetal: false)
        } ?? []

        let metalAssets: [AssetsViewModel.Asset] = commodities?.compactMap {
            $0.toViewModel(isMetal: true)
        } ?? []

        let fiatAssets: [AssetsViewModel.Asset] = fiats?.compactMap {
            $0.toViewModel()
        } ?? []

        let assetsViewModel = AssetsViewModel(cryptocoins: cryptoAssets, metals: metalAssets, fiats: fiatAssets)

        // Wallets View Model
        var wallets = wallets?.compactMap {
            $0.toViewModel(from: self, isMetal: false)
        } ?? []
        wallets.sort { $0.eurBalance > $1.eurBalance }

        var metalWallets = commodityWallets?.compactMap {
            $0.toViewModel(from: self, isMetal: true)
        } ?? []
        metalWallets.sort { $0.eurBalance > $1.eurBalance }

        var fiatWallets = fiatwallets?.compactMap {
            $0.toViewModel(from: self, userInterfaceStyle: .dark)
        } ?? []
        fiatWallets.sort { $0.eurBalance > $1.eurBalance }

        let walletsViewModel = WalletsViewModel(cryptoWallets: wallets, metalWallets: metalWallets, fiatWallets: fiatWallets)

        return WelcomeViewModels(assetsViewModel, walletsViewModel)
    }
}

extension Wallet {
    func toViewModel(from data: DataAttributes,
                     isMetal: Bool,
                     userInterfaceStyle: UIUserInterfaceStyle = UIScreen.main.traitCollection.userInterfaceStyle) -> WalletsViewModel.Wallet? {
        guard !(attributes?.deleted ?? true) else {
            return nil
        }

        let crypto = isMetal ? data.getCommodityWithId(attributes?.cryptocoinID ?? "") : data.getCryptoWithId(attributes?.cryptocoinID ?? "")
        let imageURL = crypto?.logoImageURL(userInterfaceStyle: userInterfaceStyle)

        let avgPrice = Double(crypto?.attributes?.avgPrice ?? "") ?? 0.0
        let balance = Double(attributes?.balance ?? "") ?? 0.0
        let eurBalance = avgPrice * balance

        return WalletsViewModel.Wallet(eurBalance: eurBalance,
                                       balance: attributes?.balance ?? "",
                                       symbol: attributes?.cryptocoinSymbol ?? "",
                                       name: attributes?.name ?? "",
                                       logoURL: imageURL,
                                       isDefault: attributes?.isDefault ?? false,
                                       walletType: isMetal ? .metal : .crypto)
    }
}

extension Fiatwallet {
    func toViewModel(from data: DataAttributes,
                     userInterfaceStyle: UIUserInterfaceStyle) -> WalletsViewModel.Wallet? {

        let fiat = data.getFiatWithId(attributes?.fiatID ?? "")
        let imageURL = fiat?.logoImageURL(userInterfaceStyle: userInterfaceStyle)

        let balance = Double(attributes?.balance ?? "") ?? 0.0
        let eurRate = Double(fiat?.attributes?.toEurRate ?? "") ?? 0.0

        let eurBalance = balance * eurRate

        return WalletsViewModel.Wallet(eurBalance: eurBalance,
                                       balance: self.attributes?.balance ?? "",
                                       symbol: self.attributes?.fiatSymbol ?? "",
                                       name: self.attributes?.name ?? "",
                                       logoURL: imageURL,
                                       isDefault: false,
                                       walletType: .fiat)
    }
}
