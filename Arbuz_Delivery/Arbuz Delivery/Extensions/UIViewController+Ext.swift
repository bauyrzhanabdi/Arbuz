import UIKit

extension UIViewController {

    func dismissKey() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard(_ sender: UIViewController) {
        if sender.view != nil && !(sender.view is UITextField) {
            view.endEditing(true)
        }
    }
}
