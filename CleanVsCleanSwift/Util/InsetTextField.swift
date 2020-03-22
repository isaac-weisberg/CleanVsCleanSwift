import UIKit

class InsetTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
}
