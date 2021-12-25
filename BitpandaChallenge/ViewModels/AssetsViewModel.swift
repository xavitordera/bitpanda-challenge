import Foundation

final class AssetsViewModel {
    let cryptocoins: [Asset]
    let metals: [Asset]
    let fiats: [Asset]
    var activeFilter: Filter = .crypto

    enum Filter: Int {
        case crypto = 1, commodity, fiat
    }

    struct Asset {
        let title: String
        let price: String
        let logoURL: URL?
        let type: AssetType

        enum AssetType {
            case crypto, metal, fiat
        }
    }

    init(cryptocoins: [AssetsViewModel.Asset], metals: [AssetsViewModel.Asset], fiats: [AssetsViewModel.Asset], activeFilter: AssetsViewModel.Filter = .crypto) {
       self.cryptocoins = cryptocoins
       self.metals = metals
       self.fiats = fiats
       self.activeFilter = activeFilter
   }
}
