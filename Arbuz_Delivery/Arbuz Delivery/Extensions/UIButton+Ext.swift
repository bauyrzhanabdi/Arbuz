import UIKit

extension UIButton {
    func setImage(_ iconName: String?) {
        guard
            let imageName = iconName,
            let image = UIImage(systemName: imageName)
        else { return }
        
        setImage(image, for: .normal)
    }
}
