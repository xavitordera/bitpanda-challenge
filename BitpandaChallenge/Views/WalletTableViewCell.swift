import UIKit
import Kingfisher

class WalletTableViewCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()

    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()

    private let logoView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        return imgView
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        logoView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        backgroundColor = nil
    }

    func configureCell(wallet: WalletsViewModel.Wallet, userInterfaceStyle: UIUserInterfaceStyle) {
        logoView.kf.setImage(with: wallet.logoURL,
                             placeholder: UIImage(systemName: "bitcoinsign.circle"),
                             options: [.processor(SVGImgProcessor())])
        titleLabel.text = wallet.name
        priceLabel.text = wallet.balance + " " + wallet.symbol

        if wallet.isDefault {
            backgroundColor = .lightGray
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        

        let stackViewTitle = UIStackView(arrangedSubviews: [logoView, titleLabel])
        stackViewTitle.distribution = .equalSpacing
        stackViewTitle.axis = .horizontal
        stackViewTitle.alignment = .center
        stackViewTitle.spacing = 10
        stackViewTitle.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [stackViewTitle, priceLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        addSubview(stackView)

        stackView.pinToView(contentView, insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
