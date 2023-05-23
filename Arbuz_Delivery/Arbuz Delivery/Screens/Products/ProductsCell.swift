import UIKit
import SnapKit

protocol ProductsCellDelegate: AnyObject {
    func plusButtonPressed(forCell cell: ProductsCell, product: Product)
    func minusButtonPressed(forCell cell: ProductsCell, product: Product)
}

class ProductsCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .darkGray
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var availabilityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGreen
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .systemGreen
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.setImage(UIImage(systemName: "minus"), for: .disabled)
        button.tintColor = .systemOrange
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
     
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var productView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttonView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Constants
    
    enum Constants {
        static let isAvailable: String = "Есть в наличии"
        static let notAvailable: String = "Нет в наличии"
    }
    
    // MARK: - Properties
    
    var product: Product?
    weak var delegate: ProductsCellDelegate?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(productView)
        mainStackView.addArrangedSubview(buttonView)
        
        productView.addSubview(imageView)
        productView.addSubview(availabilityLabel)
        productView.addSubview(nameLabel)
        
        buttonView.addSubview(minusButton)
        buttonView.addSubview(priceLabel)
        buttonView.addSubview(plusButton)
    }
    
    private func setupLayout() {
        mainStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        productView.snp.makeConstraints { make in
            make.height.equalTo(mainStackView).multipliedBy(0.9)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(productView)
            make.height.equalTo(productView).multipliedBy(0.8)
        }
        
        availabilityLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.left.equalTo(productView)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(availabilityLabel.snp.bottom).offset(5)
            make.left.right.equalTo(productView)
        }
        
        buttonView.snp.makeConstraints { make in
            make.height.equalTo(mainStackView).multipliedBy(0.12)
        }
        
        minusButton.snp.makeConstraints { make in
            make.left.equalTo(buttonView).offset(20)
            make.centerY.equalTo(buttonView)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(minusButton.snp.right)
            make.right.equalTo(plusButton.snp.left)
            make.center.equalTo(buttonView)
        }
        
        plusButton.snp.makeConstraints { make in
            make.right.equalTo(buttonView).offset(-20)
            make.centerY.equalTo(buttonView)
        }
    }
    
    // MARK: - Methods
    
    @objc private func plusButtonTapped(_ sender: UIButton) {
        guard let product = product else { return }
        if !product.isAvailable {
            return
        }
        product.chosenAmount += 1
        if product.chosenAmount > 0 {
            minusButton.isEnabled = true
        }
        delegate?.plusButtonPressed(forCell: self, product: product)
    }
    
    @objc private func minusButtonTapped(_ sender: UIButton) {
        guard let product = product else { return }
        if !product.isAvailable {
            return
        }
        product.chosenAmount -= 1
        if product.chosenAmount == 0 {
            minusButton.isEnabled = false
        }
        delegate?.minusButtonPressed(forCell: self, product: product)
    }
    
    
    func configure(with product: Product) {
        self.product = product
        let weightString = calculateWeight(product.weight, product.measure)
        imageView.image = UIImage(named: product.imageName)
        nameLabel.text = "\(product.name) \(weightString)"
        priceLabel.text = "\(product.price) ₸"
        availabilityLabel.text = product.isAvailable ? Constants.isAvailable : Constants.notAvailable
        availabilityLabel.textColor = product.isAvailable ? .systemGreen : .systemOrange
    }
    
    private func calculateWeight(_ weight: Int, _ measure: MeasureUnit) -> String {
        switch measure {
        case .gram:
            return weight % 1000 == 0 ? "\(weight / 1000) кг" : "\(weight) г"
        case .millilitre:
            return weight % 1000 == 0 ? "\(weight / 1000) л" : "\(weight) мл"
        case .kilogram, .litre, .piece:
            return "\(weight) \(measure.rawValue)"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = ""
        priceLabel.text = ""
        availabilityLabel.text = ""
    }
    
}
