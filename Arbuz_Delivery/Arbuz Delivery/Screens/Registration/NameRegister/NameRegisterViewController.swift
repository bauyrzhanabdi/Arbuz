import UIKit
import SnapKit


class NameRegisterViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите имя и фамилию"
        label.textAlignment = .center
        label.textColor = .systemGreen
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight(1))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        textField.tintColor = .systemGreen
        textField.addBottomBorder()
        textField.clipsToBounds = true
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var surnameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Фамилия"
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        textField.tintColor = .systemGreen
        textField.addBottomBorder()
        textField.clipsToBounds = true
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = .systemGray3
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(1))
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        button.clipsToBounds = true
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var authorizationView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Properties
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    private let spacing: CGFloat = 20
    var registerUser: User?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        authorizationView.addArrangedSubview(nameField)
        authorizationView.addArrangedSubview(surnameField)
        
        view.addSubview(nameLabel)
        view.addSubview(authorizationView)
        view.addSubview(nextButton)
    }
    
    private func setupLayout() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(screenWidth / 2)
            make.left.equalTo(view).offset(30)
        }
        
        authorizationView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(50)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(screenWidth / 3)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalTo(authorizationView)
            make.bottom.equalTo(view).offset(-100)
            make.height.equalTo(screenWidth / 6 - spacing / 2)
        }
    }
    
    // MARK: - Methods
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        guard let name = nameField.text else { return }
        guard let surname = surnameField.text else { return }
        updateRegisterUser(name: name, surname: surname)
        
        let controller = UsernameRegisterViewController()
        controller.registerUser = registerUser
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        vaildateNameAndSurname()
    }
    
    private func vaildateNameAndSurname() {
        guard let name = nameField.text else { return }
        guard let surname = surnameField.text else { return }

        let regex = try? NSRegularExpression(pattern: ".*[^A-Za-zА-Яа-я-].*", options: [])
        let nameCheck = regex?.firstMatch(in: name, range: NSRange(location: 0, length: name.count))
        let surnameCheck = regex?.firstMatch(in: surname, range: NSRange(location: 0, length: surname.count))

        if !name.isEmpty && !surname.isEmpty &&
            name.count <= 64 && surname.count <= 64 &&
            nameCheck == nil && surnameCheck == nil {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .systemGreen
            nextButton.setTitleColor(.white, for: .normal)
            dismissKey()
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .systemGray3
            nextButton.setTitleColor(.darkGray, for: .normal)
            dismissKey()
        }
    }
    
    private func updateRegisterUser(name: String, surname: String) {
        registerUser = User(name: name, surname: surname, username: nil, password: nil)
    }

}

extension NameRegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
