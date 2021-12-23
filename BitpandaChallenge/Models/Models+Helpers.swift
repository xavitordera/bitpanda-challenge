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
