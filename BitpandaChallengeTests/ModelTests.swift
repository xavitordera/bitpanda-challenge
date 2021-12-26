//
//  ModelTests.swift
//  BitpandaChallengeTests
//
//  Created by Xavier Tordera on 26/12/21.
//

import XCTest
@testable import BitpandaChallenge

class ModelTests: XCTestCase {

    func testCommodityLogoImage() {
        // Given
        let commodity = Commodity.mock()
        // When
        let url = commodity.logoImageURL(userInterfaceStyle: .dark)
        // Then
        XCTAssertEqual(URL(string: "http://logo_dark.com"), url)
    }

    func testFiatLogoImage() {
        // Given
        let commodity = Fiat.mock()
        // When
        let url = commodity.logoImageURL(userInterfaceStyle: .dark)
        // Then
        XCTAssertEqual(URL(string: "http://logo_dark.com"), url)
    }

    func testCommodityToViewModel() {
        // Given
        let commodity = Commodity.mock()
        let expectedViewModel = AssetsViewModel.Asset(title: "name", price: "€100.00", logoURL: URL(string: "http://logo.com"), type: .metal)
        // When
        let viewModel = commodity.toViewModel(isMetal: true, style: .light)
        // Then
        XCTAssertEqual(viewModel, expectedViewModel)
    }

    func testFiatToViewModel() {
        // Given
        let fiat = Fiat.mock()
        let expectedViewModel = AssetsViewModel.Asset(title: "name", price: "symbol", logoURL: URL(string: "http://logo.com"), type: .fiat)
        // When
        let viewModel = fiat.toViewModel(style: .light)
        // Then
        XCTAssertEqual(viewModel, expectedViewModel)
    }

    func testWalletToViewModel() {
        // Given+
        let welcome = Welcome.mock()
        let wallet: Wallet = .mock()
        let expectedViewModel = WalletsViewModel.Wallet(eurBalance: 100, balance: "1", symbol: "BTC", name: "Bitcoin Wallet", logoURL: URL(string: "http://logo_dark.com"), isDefault: true, walletType: .crypto)
        // When
        let viewModel = wallet.toViewModel(from: welcome.data!.attributes!, isMetal: false)
        // Then
        XCTAssertEqual(expectedViewModel, viewModel)
    }

    func testFiatwalletToViewModel() {
        // Given+
        let welcome = Welcome.mock()
        let wallet: Fiatwallet = .mock()
        let expectedViewModel = WalletsViewModel.Wallet(eurBalance: 1.0, balance: "1", symbol: "EUR", name: "EUR Wallet", logoURL: URL(string: "http://logo.com"), isDefault: false, walletType: .fiat)
        // When
        let viewModel = wallet.toViewModel(from: welcome.data!.attributes!, style: .light)
        // Then
        XCTAssertEqual(expectedViewModel, viewModel)
    }

    func testWelcomeToViewModels() {
        // Given
        let welcome = Welcome.mock()
        let expectedAssetsViewModel = AssetsViewModel(cryptocoins: [Commodity.mock().toViewModel(isMetal: false)], metals: [Commodity.mock().toViewModel(isMetal: true)], fiats: [Fiat.mock().toViewModel()!])

        let expectedWalletViewModel = WalletsViewModel(cryptoWallets: [Wallet.mock().toViewModel(from: welcome.data!.attributes!, isMetal: false)!], metalWallets: [Wallet.mock().toViewModel(from: welcome.data!.attributes!, isMetal: true)!], fiatWallets: [Fiatwallet.mock().toViewModel(from: welcome.data!.attributes!)!])
        // When
        let viewModels = welcome.data?.attributes?.toViewModels()
        // Then
        XCTAssertEqual(expectedAssetsViewModel, viewModels!.0)
        XCTAssertEqual(expectedWalletViewModel, viewModels!.1)
    }
}
