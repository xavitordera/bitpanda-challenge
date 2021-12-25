//
//  Models.swift
//  BitpandaChallenge
//
//  Created by Xavier Tordera on 21/12/21.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let type: String?
    let attributes: DataAttributes?
}

// MARK: - DataAttributes
struct DataAttributes: Codable {
    let cryptocoins, commodities: [Commodity]?
    let fiats: [Fiat]?
    let wallets, commodityWallets: [Wallet]?
    let fiatwallets: [Fiatwallet]?

    enum CodingKeys: String, CodingKey {
        case cryptocoins, commodities, fiats, wallets
        case commodityWallets = "commodity_wallets"
        case fiatwallets
    }
}

// MARK: - Commodity
struct Commodity: Codable {
    let attributes: CommodityAttributes?
    let id: String?
}

// MARK: - CommodityAttributes
struct CommodityAttributes: Codable {
    let symbol, name: String?
    let precisionForFiatPrice, precisionForCoins: Int?
    let avgPrice: String?
    let logo, logoDark: String?

    enum CodingKeys: String, CodingKey {
        case symbol, name
        case precisionForFiatPrice = "precision_for_fiat_price"
        case precisionForCoins = "precision_for_coins"
        case avgPrice = "avg_price"
        case logo
        case logoDark = "logo_dark"
    }
}

// MARK: - Wallet
struct Wallet: Codable {
    let type: CommodityWalletType?
    let attributes: CommodityWalletAttributes?
    let id: String?
}

// MARK: - CommodityWalletAttributes
struct CommodityWalletAttributes: Codable {
    let cryptocoinID, cryptocoinSymbol, balance: String?
    let isDefault: Bool?
    let name: String?
    let pendingTransactionsCount: Int?
    let deleted: Bool?

    enum CodingKeys: String, CodingKey {
        case cryptocoinID = "cryptocoin_id"
        case cryptocoinSymbol = "cryptocoin_symbol"
        case balance
        case isDefault = "is_default"
        case name
        case pendingTransactionsCount = "pending_transactions_count"
        case deleted
    }
}

enum CommodityWalletType: String, Codable {
    case wallet = "wallet"
}

// MARK: - Fiat
struct Fiat: Codable {
    let type: String?
    let attributes: FiatAttributes?
    let id: String?
}

// MARK: - FiatAttributes
struct FiatAttributes: Codable {
    let symbol, name: String?
    let precision: Int?
    let toEurRate: String?
    let symbolCharacter: String?
    let hasWallets: Bool?
    let logo, logoDark, logoWhite, logoColor: String?

    enum CodingKeys: String, CodingKey {
        case symbol, name, precision
        case toEurRate = "to_eur_rate"
        case symbolCharacter = "symbol_character"
        case hasWallets = "has_wallets"
        case logo
        case logoDark = "logo_dark"
        case logoWhite = "logo_white"
        case logoColor = "logo_color"
    }
}

// MARK: - Fiatwallet
struct Fiatwallet: Codable {
    let type: String?
    let attributes: FiatwalletAttributes?
    let id: String?
}

// MARK: - FiatwalletAttributes
struct FiatwalletAttributes: Codable {
    let fiatID, fiatSymbol, balance, name: String?
    let pendingTransactionsCount: Int?

    enum CodingKeys: String, CodingKey {
        case fiatID = "fiat_id"
        case fiatSymbol = "fiat_symbol"
        case balance, name
        case pendingTransactionsCount = "pending_transactions_count"
    }
}

