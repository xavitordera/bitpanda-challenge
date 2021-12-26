@testable import BitpandaChallenge

extension Commodity {
    static func mock(symbol: String = "symbol",
              name: String = "name",
              precisionForFiatPrice: Int = 2,
              precisionForCoins: Int = 2,
              avgPrice: String = "100",
              logo: String = "http://logo.com",
              logoDark: String = "http://logo_dark.com") -> Commodity {
        Commodity(attributes: CommodityAttributes(symbol: symbol, name: name, precisionForFiatPrice: precisionForFiatPrice, precisionForCoins: precisionForCoins, avgPrice: avgPrice, logo: logo, logoDark: logoDark), id: "id")
    }
}

extension Fiat {
    static func mock(symbol: String = "symbol",
              name: String = "name",
              precision: Int = 2,
              precisionForCoins: Int = 2,
              toEurRate: String = "1",
              symbolCharacter: String = "€",
              hasWallets: Bool = true,
              logo: String = "http://logo.com",
              logoDark: String = "http://logo_dark.com") -> Fiat {
        Fiat(type: "", attributes: FiatAttributes(symbol: symbol,
                                                  name: name,
                                                  precision: precision,
                                                  toEurRate: toEurRate,
                                                  symbolCharacter: symbolCharacter,
                                                  hasWallets: hasWallets,
                                                  logo: logo,
                                                  logoDark: logoDark),
             id: "id")
    }
}

extension Wallet {
    static func mock(
        cryptocoinID: String = "id",
        cryptocoinSymbol: String = "BTC",
        balance: String = "1",
        isDefault: Bool = true,
        name: String = "Bitcoin Wallet",
        deleted: Bool = false
    ) -> Wallet {
        Wallet(type: .wallet, attributes: CommodityWalletAttributes(cryptocoinID: cryptocoinID, cryptocoinSymbol: cryptocoinSymbol, balance: balance, isDefault: isDefault, name: name, pendingTransactionsCount: 0, deleted: deleted), id: "id")
    }
}
extension Fiatwallet {
    static func mock(
        fiatID: String = "id",
        fiatSymbol: String = "EUR",
        balance: String = "1",
        name: String = "EUR Wallet"
    ) -> Fiatwallet {
        Fiatwallet(type: "", attributes: FiatwalletAttributes(fiatID: fiatID, fiatSymbol: fiatSymbol, balance: balance, name: name, pendingTransactionsCount: 0), id: "id")
    }
}

extension Welcome {
    static func mock(
        cryptocoins: [Commodity] = [.mock()],
        commodities: [Commodity] = [.mock()],
        fiats: [Fiat] = [.mock()],
        wallets: [Wallet] = [.mock()],
        commodityWallets: [Wallet] = [.mock()],
        fiatwallets: [Fiatwallet] = [.mock()]
    ) -> Welcome {
        Welcome(data: DataClass(type: "", attributes: DataAttributes(cryptocoins: cryptocoins, commodities: commodities, fiats: fiats, wallets: wallets, commodityWallets: commodityWallets, fiatwallets: fiatwallets)))
    }
}
