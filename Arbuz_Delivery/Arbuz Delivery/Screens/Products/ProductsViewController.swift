import UIKit
import SnapKit

protocol ProductsViewControllerDelegate: AnyObject {
    func addToCart(product: Product)
    func removeFromCart(product: Product)
}

class ProductsViewController: UIViewController, ProductsCellDelegate {
    
    // MARK: - Outlets
    
    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arbuz")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Добро пожаловать"
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .darkGray
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "\(user?.name ?? "Арбузер") \(user?.surname ?? "")"
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .systemGreen
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductsCell.self, forCellWithReuseIdentifier: ProductsCell.identifier)
        collectionView.register(ProductsCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProductsCellHeader.identifier)
        return collectionView
    }()
    
    // MARK: - Properties
    
    var user: User?
    private var products: [[Product]]?
    weak var delegate: ProductsViewControllerDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        loadData()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupHierarchy() {
        addressView.addArrangedSubview(cityLabel)
        addressView.addArrangedSubview(nameLabel)
        
        topView.addSubview(logoView)
        topView.addSubview(addressView)
        
        view.addSubview(topView)
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        topView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(50)
        }
        
        logoView.snp.makeConstraints { make in
            make.centerY.left.equalTo(topView)
            make.height.equalTo(topView.snp.height)
            make.width.equalTo(100)
        }
        
        addressView.snp.makeConstraints { make in
            make.centerY.right.equalTo(topView)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(addressView)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom)
            make.left.right.equalTo(addressView)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    // MARK: - Methods
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.4))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: layoutItem, count: 1)
            layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)
            layoutGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(1)
            
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .groupPaging
            
            let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93),
                                                                 heightDimension: .estimated (50))
            let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                                  elementKind: UICollectionView.elementKindSectionHeader,
                                                                                  alignment: .top)
            layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
            
            return layoutSection
        }
    }
    
    private func loadData() {
        let model = ProductsModel()
        self.products = model.createModels()
        collectionView.reloadData()
    }
    
    func plusButtonPressed(forCell cell: ProductsCell, product: Product) {
        delegate?.addToCart(product: product)
    }
    
    func minusButtonPressed(forCell cell: ProductsCell, product: Product) {
        delegate?.removeFromCart(product: product)
    }
    
}

// MARK: - Extensions

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let products = products else { return 1 }
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let products = products else { return 1 }
        return products[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCell.identifier, for: indexPath) as? ProductsCell,
            let products = products
        else { return UICollectionViewCell() }
        cell.delegate = self
        cell.configure(with: products[indexPath.section][indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProductsCellHeader.identifier, for: indexPath) as? ProductsCellHeader else { return UICollectionReusableView() }
        
        switch indexPath.section {
        case 0:
            header.title.text = "Молочная продукция"
        case 1:
            header.title.text = "Фрукты и ягоды"
        case 2:
            header.title.text = "Свежие овощи"
        default:
            header.title.text = ""
        }
        
        return header
    }
}
