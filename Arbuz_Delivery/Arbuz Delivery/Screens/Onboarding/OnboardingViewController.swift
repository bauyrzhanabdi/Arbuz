import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Constants

    enum Metric {
        static let buttonHeight: CGFloat = 44
        static let topOffset: CGFloat = 25
        static let leftOffset: CGFloat = 40
        static let rightOffset: CGFloat = -40
        static let bottomOffset: CGFloat = -50
        static let spacing: CGFloat = 16
        static let multiplier: CGFloat = 3/4
    }

    enum Strings {
        static let nextButtonTitle: String = "Далее"
        static let startButtonTitle: String = "Погнали"
    }
    
    // MARK: - Outlets

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Metric.spacing
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var collectionView: UICollectionView = {        
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        return collectionView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGreen
        pageControl.currentPageIndicatorTintColor = .systemOrange
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    private lazy var controlButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.tintColor = .white
        button.layer.cornerRadius = Metric.buttonHeight / 2
        button.addTarget(self, action: #selector(controlButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    
    var user: User?
    private var model: OnboardingModel?
    private var models: [Onboarding] = []
    private var currentPageIndex = 0 {
        didSet{
            let isLastPage = models.count - 1 > currentPageIndex
            controlButton.setTitle(isLastPage ? Strings.nextButtonTitle : Strings.startButtonTitle, for: .normal)
            controlButton.backgroundColor = isLastPage ? .darkGray : .systemGreen
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configure()
    }
    
    // MARK: - Setup

    private func setup() {
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }

    private func setupHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(controlButton)
    }

    private func setupLayout() {
        
        collectionView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view)
            make.height.equalTo(view).multipliedBy(Metric.multiplier)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(Metric.topOffset)
            make.left.equalTo(view).offset(Metric.leftOffset)
            make.right.equalTo(view).offset(Metric.rightOffset)
            make.bottom.equalTo(view).offset(Metric.bottomOffset)
        }
        
        controlButton.snp.makeConstraints { make in
            make.height.equalTo(Metric.buttonHeight)
        }
    }
    
    // MARK: - Methods
    
    @objc private func controlButtonTapped(_ sender: UIButton) {
        if currentPageIndex == models.count - 1 {
            let productsViewController = ProductsViewController()
            let cartViewController = CartViewController()
            
            productsViewController.user = user
            cartViewController.user = user
            
            productsViewController.delegate = cartViewController
            
            let controller = UITabBarController()
            controller.setupTabBarController(productsViewController, cartViewController)
            navigationController?.pushViewController(controller, animated: true)
            return
        }
        
        currentPageIndex += 1
        let indexPath = IndexPath(item: currentPageIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentPageIndex
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: layoutItem, count: 1)
            layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)
            layoutGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(1)
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .groupPaging
            return layoutSection
        }
    }

    func configure() {
        self.model = OnboardingModel()
        guard let models = model?.createModels() else { return }
        self.models = models
        pageControl.numberOfPages = models.count
        pageControl.currentPage = 0
        currentPageIndex = 0
        collectionView.reloadData()
    }
    
}


extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let newIndexOfPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl.currentPage = newIndexOfPage
        currentPageIndex = newIndexOfPage
    }
}
