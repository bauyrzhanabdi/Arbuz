import UIKit
import SnapKit

class CartCell: UICollectionViewCell {
    
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
        label.numberOfLines = 2
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
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .systemGreen
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Constants
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    
    // MARK: - Properties
    
    var product: Product?
    
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
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(amountLabel)
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(self)
            make.width.equalTo(screenWidth/4)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-10)
            make.left.equalTo(imageView.snp.right).offset(10)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
        }
    }
    
    // MARK: - Methods
    
    func configure(with product: Product) {
        self.product = product
        let weightString = calculateWeight(product.weight, product.measure)
        let measureString = getCorrectMeasure(measure: product.measure)
        imageView.image = UIImage(named: product.imageName)
        nameLabel.text = "\(product.name) \(weightString)"
        priceLabel.text = "\(product.price * product.chosenAmount) ₸"
        amountLabel.text = "\(product.chosenAmount) \(measureString)"
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
    
    private func getCorrectMeasure(measure: MeasureUnit) -> String {
        switch measure {
        case .kilogram, .litre, .piece:
            return measure.rawValue
        case .gram, .millilitre:
            return "шт"
        }
    }
    
}
