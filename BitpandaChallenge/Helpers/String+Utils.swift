import Foundation

extension String {
    func formattedPrice(locale: Locale = .current,
                        currencyCode: String = "EUR",
                        precision: Int = 0) -> String? {
        let formatter = NumberFormatter()

        if let price = formatter.number(from: self) {
            formatter.numberStyle = .currency
            formatter.currencyCode = currencyCode
            formatter.locale = locale
            formatter.maximumFractionDigits = precision

            return formatter.string(from: price)
        }

        return nil
    }
}
