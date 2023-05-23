import UIKit
import SnapKit

class UsernameRegisterViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Задайте имя пользователя"
        label.textAlignment = .center
        label.textColor = .systemGreen
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight(1))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var usernameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя пользователя"
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
    
    private lazy var usernameStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя пользователя не состоит из латинских букв"
        label.textColor = .clear
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        authorizationView.addArrangedSubview(usernameField)
        
        view.addSubview(nameLabel)
        view.addSubview(authorizationView)
        view.addSubview(usernameStatusLabel)
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
            make.height.equalTo(screenWidth / 6)
        }
        
        usernameStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(authorizationView.snp.bottom)
            make.left.right.equalTo(authorizationView)
            make.height.equalTo(15)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalTo(authorizationView)
            make.bottom.equalTo(view).offset(-100)
            make.height.equalTo(screenWidth / 6 - spacing / 2)
        }
    }
    
    // MARK: - Methods
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        guard let username = usernameField.text else { return }
        updateRegisterUser(username: username)
        
        let controller = PasswordRegisterViewController()
        controller.registerUser = registerUser
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        validateUsername()
    }
    
    private func validateUsername() {
        guard let username = usernameField.text else { return }

        let regex = try? NSRegularExpression(pattern: ".*[^A-Za-z\\d-].*", options: [])
        let nameCheck = regex?.firstMatch(in: username, range: NSRange(location: 0, length: username.count))
        let usernameAlreadyExists = usernameAlreadyExists(username: username)
        
        if !username.isEmpty &&
            username.count <= 64 &&
            nameCheck == nil &&
            !usernameAlreadyExists {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .systemGreen
            nextButton.setTitleColor(.white, for: .normal)
            usernameStatusLabel.textColor = .clear
            dismissKey()
        }
        else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .systemGray3
            nextButton.setTitleColor(.darkGray, for: .normal)
            usernameStatusLabel.textColor = .red
            usernameStatusLabel.text = getStatusName(usernameAlreadyExists)
            dismissKey()
        }
    }
    
    private func updateRegisterUser(username: String) {
        registerUser?.username = username
    }
    
    private func usernameAlreadyExists(username: String) -> Bool {
        if let storedData = UserDefaults.standard.data(forKey: "key") {
            do {
                let storedUsers = try JSONDecoder().decode([User].self, from: storedData)
                return storedUsers.contains(where: { $0.username == username })
            } catch {
                fatalError("Error decoding user data: \(error)")
            }
        }
        return false
    }
    
    private func getStatusName(_ usernameAlreadyExists: Bool) -> String {
        return usernameAlreadyExists ? "Имя пользователя уже существует" : "Имя пользователя не состоит из латинских букв"
    }

}

extension UsernameRegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

