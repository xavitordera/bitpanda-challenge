import Foundation

final class AssetsViewModel {
    let cryptocoins: [Asset]
    let metals: [Asset]
    let fiats: [Asset]
    var activeFilter: Filter = .crypto
    let title: String = "assets".localized

    enum Filter: Int, CaseIterable {
        case crypto = 1, commodity, fiat

        var title: String {
            switch self {
            case .crypto:
                return "crypto".localized
            case .commodity:
                return "metals".localized
            case .fiat:
                return "fiats".localized
            }
        }
    }

    struct Asset: Equatable {
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


extension AssetsViewModel: Equatable {
    static func == (lhs: AssetsViewModel, rhs: AssetsViewModel) -> Bool {
        lhs.cryptocoins == rhs.cryptocoins &&
        lhs.metals == rhs.metals &&
        lhs.fiats == rhs.fiats &&
        lhs.activeFilter == rhs.activeFilter
    }
}
