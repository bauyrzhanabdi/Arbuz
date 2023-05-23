import UIKit
import SnapKit

extension UITextField {
    func setLeftIcon(_ iconName: String?, color: UIColor = .darkGray) {
        guard let imageName = iconName, let image = UIImage(systemName: imageName) else { return }
        let iconView = UIImageView(frame: CGRect(x: 30, y: 5, width: 25, height: 20))
        iconView.image = image
        iconView.tintColor = color
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 70, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    func setRightIcon(_ iconName: String?, color: UIColor = .darkGray) {
        guard let imageName = iconName, let image = UIImage(systemName: imageName) else { return }
        let iconView = UIImageView(frame: CGRect(x: 0, y: 5, width: 25, height: 20))
        iconView.image = image
        iconView.tintColor = color
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }
    
    func setRightButton(_ iconName: String?, button: UIButton) {
        guard
            let imageName = iconName,
            let image = UIImage(systemName: imageName)
        else { return }
        
        button.frame = CGRect(x: 0, y: 5, width: 25, height: 20)
        button.setImage(image, for: .normal)
        
        let buttonContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        buttonContainerView.addSubview(button)
        rightView = buttonContainerView
        rightViewMode = .always
    }
    
    func addBottomBorder(height: CGFloat = 1.0, color: UIColor = .darkGray) {
        let borderView = UIView()
        borderStyle = .none
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)
        
        borderView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(height)
        }
    }
    
    func clear() {
        text = ""
    }
}
