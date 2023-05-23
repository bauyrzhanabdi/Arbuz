import UIKit
import SnapKit

class CartViewController: UIViewController, ProductsViewControllerDelegate {
    
    // MARK: - Outlets
    
    private lazy var emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "emptycart.jpeg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Стоимость доставки: "
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .darkGray
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deliveryPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "бесплатно"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .systemGreen
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
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
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: CartCell.identifier)
        return collectionView
    }()
    
    private lazy var totalDescription: UILabel = {
        let label = UILabel()
        label.text = "Итого: "
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .darkGray
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "бесплатно"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .systemGreen
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Перейти к оформлению", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.alpha = 0.7
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Constants
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    
    // MARK: - Properties
    
    var user: User?
    private var cart: [Product] = [] {
        didSet {
            setup()
            countTotalPrice()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        if cart.isEmpty {
            clearView()
            setupEmptyView()
        } else {
            clearEmptyView()
            setupHierarchy()
            setupLayout()
            collectionView.reloadData()
        }
    }
    
    private func setupHierarchy() {
        view.addSubview(deliveryLabel)
        view.addSubview(deliveryPriceLabel)
        view.addSubview(borderView)
        view.addSubview(collectionView)
        view.addSubview(totalDescription)
        view.addSubview(totalPriceLabel)
        view.addSubview(nextButton)
    }
    
    private func setupLayout() {
        deliveryLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(70)
            make.left.equalTo(view).offset(30)
        }
        
        deliveryPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(deliveryLabel)
            make.left.equalTo(deliveryLabel.snp.right)
        }
        
        borderView.snp.makeConstraints { make in
            make.top.equalTo(deliveryLabel.snp.bottom).offset(10)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom).offset(30)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(totalDescription.snp.top).offset(-10)
        }
        
        totalDescription.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
            make.left.equalTo(view).offset(30)
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
            make.left.equalTo(totalDescription.snp.right)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalTo(borderView)
            make.bottom.equalTo(view).offset(-100)
            make.height.equalTo(50)
        }
    }
    
    private func setupEmptyView() {
        view.addSubview(emptyImageView)
        
        emptyImageView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.width.equalTo(screenWidth * 0.8)
        }
    }
    
    private func clearEmptyView() {
        if view.subviews.contains(emptyImageView) {
            clearView()
        }
    }
    
    private func clearView() {
        view.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        view.removeConstraints(view.constraints)
    }

    
    // MARK: - Methods
    
    func addToCart(product: Product) {
        if let index = cart.firstIndex(where: { $0.id == product.id }) {
            cart[index].chosenAmount += 1
            collectionView.reloadData()
            return
        }
        
        cart.append(product)
        collectionView.reloadData()
    }
    
    func removeFromCart(product: Product) {
        if let index = cart.firstIndex(where: { $0.id == product.id }) {
            if cart[index].chosenAmount == 0 {
                cart.remove(at: index)
                collectionView.reloadData()
                return
            }
            
            cart[index].chosenAmount -= 1
            collectionView.reloadData()
        }
    }
    
    private func countTotalPrice() {
        var price: Int = 0
        
        cart.forEach { product in
            price += product.price * product.chosenAmount
        }
        
        totalPriceLabel.text = "\(price) ₸"
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/6))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: layoutItem, count: 1)
            layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)
            layoutGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(1)
            
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            
            return layoutSection
        }
    }
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        let controller = OrderViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - Extensions

extension CartViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCell.identifier, for: indexPath) as? CartCell else { return UICollectionViewCell() }
        cell.configure(with: cart[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

