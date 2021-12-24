final class AssetsViewModel {
    init(attributes: DataAttributes,
         activeFilter: AssetsViewModel.Filter = .crypto) {
        self.attributes = attributes
        self.activeFilter = activeFilter
    }

    private let attributes: DataAttributes

    lazy var cryptocoins: [Commodity] = {
        attributes.cryptocoins ?? []
    }()

    lazy var metals: [Commodity] = {
        attributes.commodities ?? []
    }()

    lazy var fiats: [Fiat] = {
        attributes.fiats?.filter { $0.attributes?.hasWallets ?? false } ?? []
    }()

    var activeFilter: Filter = .crypto

    enum Filter: Int {
        case crypto = 1, commodity, fiat
    }
}
