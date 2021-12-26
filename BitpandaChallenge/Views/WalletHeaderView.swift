import UIKit

class WalletHeaderView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        label.font = UIFont.boldSystemFont(ofSize: 29.0)
        label.textAlignment = .center
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        label.textAlignment = .center
        label.text = "total_balance".localized
        return label
    }()

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        let stackView = UIStackView(arrangedSubviews: [infoLabel, titleLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.alignment = .center
        addSubview(stackView)

        stackView.pinToView(self, insets: .init(top: 15.0, left: 0, bottom: 15.0, right: 0))
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
