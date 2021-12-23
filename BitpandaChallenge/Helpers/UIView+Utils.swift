import UIKit

extension UIView {
    func pinToView(_ view: UIView, insets: UIEdgeInsets) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: insets.top))
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -insets.bottom))
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: insets.left))
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -insets.right))
    }
}
