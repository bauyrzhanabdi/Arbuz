import UIKit
import SnapKit

class PasswordRegisterViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Задайте пароль"
        label.textAlignment = .center
        label.textColor = .systemGreen
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight(1))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lengthPasswordRequirementLabel: UILabel = {
        let label = UILabel()
        label.text = "Должен содержать в себе 8-64 символов"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var languagePasswordRequirementLabel: UILabel = {
        let label = UILabel()
        label.text = "Должен состоят из исключительно латинских букв"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var symbolsPasswordRequirementLabel: UILabel = {
        let label = UILabel()
        label.text = "Должен состоят как минимум из 1 заглавной буквы, 1 строчной буквы, 1 цифры и 1 специального символа (к примеру, ! @ # ?) "
        label.numberOfLines = 3
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var requirementsView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        textField.tintColor = .systemGreen
        textField.addBottomBorder()
        textField.setRightButton("eye.slash", button: passwordButton)
        textField.isSecureTextEntry = true
        textField.clipsToBounds = true
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.tag = 0
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var confirmPasswordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Подтверждение пароля"
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        textField.tintColor = .systemGreen
        textField.addBottomBorder()
        textField.setRightButton("eye.slash", button: confirmPasswordButton)
        textField.isSecureTextEntry = true
        textField.clipsToBounds = true
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.tag = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Завершить", for: .normal)
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
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var passwordButton: UIButton = {
        let button = UIButton()
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(passwordVisibilityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var confirmPasswordButton: UIButton = {
        let button = UIButton()
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(confirmPasswordVisibilityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var requirementsStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль не соответствует вышеуказанным требованиям"
        label.textColor = .clear
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var similarityStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль и подтверждение пароля не совпадают"
        label.textColor = .clear
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Properties
    
    private let validator = PasswordValidator.shared
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
        requirementsView.addArrangedSubview(lengthPasswordRequirementLabel)
        requirementsView.addArrangedSubview(languagePasswordRequirementLabel)
        requirementsView.addArrangedSubview(symbolsPasswordRequirementLabel)
        
        view.addSubview(nameLabel)
        view.addSubview(requirementsView)
        view.addSubview(passwordField)
        view.addSubview(requirementsStatusLabel)
        view.addSubview(confirmPasswordField)
        view.addSubview(similarityStatusLabel)
        view.addSubview(finishButton)
    }
    
    private func setupLayout() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(screenWidth / 2)
            make.left.equalTo(view).offset(30)
        }
        
        requirementsView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.equalTo(nameLabel)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(screenWidth / 5)
        }
    
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(requirementsView.snp.bottom).offset(50)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(screenWidth / 8)
        }
        
        requirementsStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(5)
            make.left.right.equalTo(passwordField)
            make.height.equalTo(15)
        }
        
        confirmPasswordField.snp.makeConstraints { make in
            make.top.equalTo(requirementsStatusLabel.snp.bottom)
            make.left.right.height.equalTo(passwordField)
        }
        
        similarityStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordField.snp.bottom).offset(5)
            make.left.right.height.equalTo(requirementsStatusLabel)
        }
        
        finishButton.snp.makeConstraints { make in
            make.left.right.equalTo(passwordField)
            make.bottom.equalTo(view).offset(-100)
            make.height.equalTo(screenWidth / 6 - spacing / 2)
        }
    }
    
    // MARK: - Methods
    
    @objc private func finishButtonTapped(_ sender: UIButton) {
        guard let password = passwordField.text else { return }
        updateRegisterUser(password: password)
        
        guard let registerUser = registerUser else { return }
        createUser(registerUser)
        
        showAlert { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        textField.tag % 2 == 0 ? validatePassword() : validateConfirmPassword()
    }
    
    @objc private func passwordVisibilityButtonTapped(_ sender: UIButton) {
        passwordField.isSecureTextEntry.toggle()
        passwordField.isSecureTextEntry
        ? passwordButton.setImage("eye.slash")
        : passwordButton.setImage("eye")
    }
    
    @objc private func confirmPasswordVisibilityButtonTapped(_ sender: UIButton) {
        confirmPasswordField.isSecureTextEntry.toggle()
        confirmPasswordField.isSecureTextEntry
        ? confirmPasswordButton.setImage("eye.slash")
        : confirmPasswordButton.setImage("eye")
    }
    
    private func validatePassword() {
        guard let password = passwordField.text else { return }
        
        validator.isValid(password: password)
        ? updateState(.requirementsMet)
        : updateState(.requirementsNotMet)
    }
    
    private func validateConfirmPassword() {

        guard
            let password = passwordField.text,
            let confirmPassword = confirmPasswordField.text
        else { return }
        
        validator.assertEqual(password: password, confirmPassword: confirmPassword)
        ? updateState(.passwordSame)
        : updateState(.passwordNotSame)
    }
    
    private func updateState(_ state: PasswordState) {
        switch state {
        case .requirementsNotMet:
            requirementsStatusLabel.textColor = .red
            configureNextButton(false)
        case .requirementsMet:
            requirementsStatusLabel.textColor = .clear
        case .passwordNotSame:
            similarityStatusLabel.textColor = .red
            configureNextButton(false)
        case .passwordSame:
            similarityStatusLabel.textColor = .clear
            requirementsStatusLabel.textColor == .clear ? configureNextButton(true) : configureNextButton(false)
        }
    }
    
    private func configureNextButton(_ isEnabled: Bool) {
        finishButton.isEnabled = isEnabled
        
        switch isEnabled {
        case true:
            finishButton.backgroundColor = .systemGreen
            finishButton.setTitleColor(.white, for: .normal)
        case false:
            finishButton.backgroundColor = .systemGray3
            finishButton.setTitleColor(.darkGray, for: .normal)
        }
    }
    
    private func updateRegisterUser(password: String) {
        registerUser?.password = password
    }
    
    private func createUser(_ user: User) {
        var storedUsers = [User]()
        
        if let storedData = UserDefaults.standard.data(forKey: "key") {
            do {
                storedUsers = try JSONDecoder().decode([User].self, from: storedData)
            } catch {
                fatalError("Error decoding user data: \(error)")
            }
        }
        
        storedUsers.append(user)
        
        do {
            let encodedUsers = try JSONEncoder().encode(storedUsers)
            UserDefaults.standard.set(encodedUsers, forKey: "key")
        } catch {
            fatalError("Error encoding user data: \(error)")
        }
    }
    
    private func showAlert(_ handler: @escaping () -> Void) {
        guard let username = registerUser?.username else { return }
        let controller = UIApplication.topViewController()
        let alert = UIAlertController(title: "Успех!", message: "Аккаунт \(username) был успешно создан.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default) { _ in
            handler()
        }
        alert.addAction(action)
        alert.view.tintColor = .systemGreen
        controller?.present(alert, animated: true)
    }
}

extension PasswordRegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newLength = currentText.count + string.count - range.length
        return newLength <= 64
    }
}


