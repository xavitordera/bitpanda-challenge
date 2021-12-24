import Foundation
import UIKit
extension Commodity {
    func formattedPrice(locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        if let price = formatter.number(from: self.attributes?.avgPrice ?? ""),
           let precision = self.attributes?.precisionForFiatPrice {
            formatter.numberStyle = .currency
            formatter.currencyCode = "EUR" // default EUR since this data is not specified

            formatter.locale = locale
            formatter.maximumFractionDigits = precision

            return formatter.string(from: price)
        }
        return nil
    }

    func logoImageURL(userInterfaceStyle: UIUserInterfaceStyle) -> URL? {
        if userInterfaceStyle == .dark {
            return URL(string: attributes?.logoDark ?? "")
        } else {
            return URL(string: attributes?.logo ?? "")
        }
    }
}

extension Fiat {
    func logoImageURL(userInterfaceStyle: UIUserInterfaceStyle) -> URL? {
        if userInterfaceStyle == .dark {
            return URL(string: attributes?.logoDark ?? "")
        } else {
            return URL(string: attributes?.logo ?? "")
        }
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

//    var totalBalance: Double {
//        var accumulatedBalance = 0.0
//        wallets?.forEach({ wallet in
//            let crypto = getCryptoWithId(wallet.attributes?.cryptocoinID ?? "")
//            let price = Double(crypto?.attributes?.avgPrice ?? "") ?? 0.0
//            let balance = Double(wallet.attributes?.balance ?? "") ?? 0.0
//
//            accumulatedBalance += price*balance
//        })
//
//        commodityWallets?.forEach({ wallet in
//            let crypto = getCommodityWithId(wallet.attributes?.cryptocoinID ?? "")
//            let price = Double(crypto?.attributes?.avgPrice ?? "") ?? 0.0
//            let balance = Double(wallet.attributes?.balance ?? "") ?? 0.0
//
//            accumulatedBalance += price*balance
//        })
//
//        fiatwallets?.forEach({ wallet in
//            let fiat = getFiatWithId(wallet.attributes?.fiatID ?? "")
//            let price = Double(wallet.attributes. ?? "") ?? 0.0
//            let balance = Double(fiat.attributes?.balance ?? "") ?? 0.0
//
//            accumulatedBalance += price*balance
//        })
//
//        return accumulatedBalance
//    }
}

extension Wallet {
    func toViewModel(from data: DataAttributes,
                     isMetal: Bool,
                     userInterfaceStyle: UIUserInterfaceStyle) -> WalletsViewModel.Wallet? {
        guard !(attributes?.deleted ?? true) else {
            return nil
        }

        let crypto = isMetal ? data.getCommodityWithId(attributes?.cryptocoinID ?? "") : data.getCryptoWithId(attributes?.cryptocoinID ?? "")
        let imageURL = crypto?.logoImageURL(userInterfaceStyle: userInterfaceStyle)

        return WalletsViewModel.Wallet(balance: attributes?.balance ?? "",
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
        return WalletsViewModel.Wallet(balance: self.attributes?.balance ?? "",
                                       symbol: self.attributes?.fiatSymbol ?? "",
                                       name: self.attributes?.name ?? "",
                                       logoURL: imageURL,
                                       isDefault: false,
                                       walletType: .fiat)
    }
}
