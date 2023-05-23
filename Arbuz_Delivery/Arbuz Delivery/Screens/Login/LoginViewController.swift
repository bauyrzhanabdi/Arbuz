import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "arbuz")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var usernameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя пользователя"
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        textField.tintColor = .systemGreen
        textField.layer.cornerRadius = 25
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.setLeftIcon("person")
        textField.clipsToBounds = true
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        textField.tintColor = .systemGreen
        textField.layer.cornerRadius = 25
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.setLeftIcon("lock")
        textField.setRightButton("eye.slash", button: passwordVisibilityButton)
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .touchUpInside)
        textField.clipsToBounds = true
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    private lazy var noAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Аккаунт не существует или данные введены неправильно"
        label.textColor = .clear
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Еще нет аккаунта?"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(1))
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var passwordVisibilityButton = {
        let button = UIButton()
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(passwordVisibilityButtonTapped), for: .touchUpInside)
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
    
    private lazy var registrationView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    private let spacing: CGFloat = 20
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        authorizationView.addArrangedSubview(usernameField)
        authorizationView.addArrangedSubview(passwordField)
        
        registrationView.addSubview(registrationLabel)
        registrationView.addSubview(registrationButton)
        
        view.addSubview(logo)
        view.addSubview(authorizationView)
        view.addSubview(noAccountLabel)
        view.addSubview(registrationView)
        view.addSubview(loginButton)
    }
    
    private func setupLayout() {
        logo.snp.makeConstraints { make in
            make.left.equalTo(view).offset(100)
            make.right.equalTo(view).offset(-100)
            make.bottom.equalTo(authorizationView.snp.top).offset(-70)
        }
        
        authorizationView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(screenWidth / 3)
        }
        
        noAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(authorizationView.snp.bottom).offset(5)
            make.centerX.equalTo(authorizationView)
            make.height.equalTo(15)
        }
        
        registrationView.snp.makeConstraints { make in
            make.top.equalTo(noAccountLabel.snp.bottom).offset(5)
            make.left.equalTo(registrationLabel)
            make.right.equalTo(registrationButton)
            make.centerX.equalTo(authorizationView)
            make.height.equalTo(registrationButton.snp.height)
        }
        
        registrationLabel.snp.makeConstraints { make in
            make.left.centerY.equalTo(registrationView)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.left.equalTo(registrationLabel.snp.right).offset(3)
            make.centerY.equalTo(registrationView)
        }
        
        loginButton.snp.makeConstraints { make in
            make.left.right.equalTo(authorizationView)
            make.bottom.equalTo(view).offset(-100)
            make.height.equalTo(screenWidth / 6 - spacing / 2)
        }
    }
    
    // MARK: - Methods
    
    @objc private func registrationButtonTapped(_ sender: UIButton) {
        let controller = NameRegisterViewController()
        clearFields()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func loginButtonTapped(_ sender: UIButton) {
        guard
            let username = usernameField.text,
            let password = passwordField.text
        else { return }
        
        if let user = getUser(username: username, password: password) {
            let controller = OnboardingViewController()
            controller.user = user
            navigationController?.pushViewController(controller, animated: true)
            return
        }
        
        noAccountLabel.textColor = .red
    }
    
    @objc private func passwordVisibilityButtonTapped(_ sender: UIButton) {
        passwordField.isSecureTextEntry.toggle()
        passwordField.isSecureTextEntry
        ? passwordVisibilityButton.setImage("eye.slash")
        : passwordVisibilityButton.setImage("eye")
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        dismissKey()
    }
    
    private func getUser(username: String, password: String) -> User? {
        if let storedData = UserDefaults.standard.data(forKey: "key") {
            do {
                let storedUsers = try JSONDecoder().decode([User].self, from: storedData)
                return storedUsers.first(where: { $0.username == username && $0.password == password })
            } catch {
                fatalError("Error decoding user data: \(error)")
            }
        }
        return nil
    }
    
    private func clearFields() {
        usernameField.clear()
        passwordField.clear()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        noAccountLabel.textColor = .clear
    }
}

