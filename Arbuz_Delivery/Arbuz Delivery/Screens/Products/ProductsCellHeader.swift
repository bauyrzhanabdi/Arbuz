import UIKit
import SnapKit

class ProductsCellHeader: UICollectionReusableView {
    
    // MARK: - Outlets
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        addSubview(title)
    }
    
    private func setupLayout() {
        title.snp.makeConstraints { make in
            make.left.centerY.equalTo(self)
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
    }
}
