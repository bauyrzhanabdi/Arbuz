import UIKit
import SnapKit

class OrderViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Пожалуйста заполните данные для оформления подписки на доставку продуктов"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 3
        label.textColor = .systemGreen
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите ваш адрес"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .darkGray
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Адрес"
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        textField.tintColor = .systemGreen
        textField.layer.cornerRadius = 25
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.setLeftIcon("location")
        textField.clipsToBounds = true
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите ваш номер телефона"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .darkGray
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Номер телефона"
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        textField.tintColor = .systemGreen
        textField.layer.cornerRadius = 25
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.setLeftIcon("phone")
        textField.clipsToBounds = true
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Оплатить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Constants
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(messageLabel)
        view.addSubview(addressLabel)
        view.addSubview(addressField)
        view.addSubview(phoneLabel)
        view.addSubview(phoneField)
        view.addSubview(payButton)
    }
    
    private func setupLayout() {
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(screenWidth/2)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(50)
            make.left.right.equalTo(messageLabel)
        }
        
        addressField.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(10)
            make.left.right.equalTo(messageLabel)
            make.height.equalTo(screenWidth / 8)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(addressField.snp.bottom).offset(30)
            make.left.right.equalTo(messageLabel)
        }
        
        phoneField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
            make.left.right.equalTo(messageLabel)
            make.height.equalTo(addressField)
        }
        
        payButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-100)
            make.left.right.equalTo(messageLabel)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Methods
    
    @objc private func payButtonTapped(_ sender: UIButton) {
        showAlert()
    }
    
    private func showAlert() {
        let controller = UIApplication.topViewController()
        let alert = UIAlertController(title: "Успех!", message: "Еженедельная подписка на выбранные вами продукты успешно оформлена!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        alert.view.tintColor = .systemGreen
        controller?.present(alert, animated: true)
    }
    
}
