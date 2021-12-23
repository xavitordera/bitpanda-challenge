import Foundation

final class AssetsViewModel: ObservableObject {
    let cryptocoins: [Commodity]
    let metals: [Commodity]
    let fiats: [Fiat]
    @Published var activeFilter: Filter = .crypto

    enum Filter: Int {
        case crypto = 1, commodity, fiat
    }

    init(cryptocoins: [Commodity],
         commodities: [Commodity],
         fiats: [Fiat]) {
        self.cryptocoins = cryptocoins
        self.metals = commodities
        self.fiats = fiats.filter { $0.attributes?.hasWallets ?? false }
    }
}
