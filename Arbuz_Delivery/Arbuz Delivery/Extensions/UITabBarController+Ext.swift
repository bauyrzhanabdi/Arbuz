import UIKit

extension UITabBarController {
    func setupTabBarController(_ productsViewController: UIViewController, _ cartViewController: UIViewController) {
        let productsItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        productsViewController.tabBarItem = productsItem
        let productsNavigationViewController = UINavigationController(rootViewController: productsViewController)
        
        let cartItem = UITabBarItem(title: nil, image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        cartViewController.tabBarItem = cartItem
        let cartNavigationViewController = UINavigationController(rootViewController: cartViewController)
        
        let controllers = [productsViewController, cartViewController]
        
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.iconColor = .darkGray
        appearance.stackedLayoutAppearance.selected.iconColor = .systemGreen
             
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
        self.navigationItem.hidesBackButton = true
        self.setViewControllers(controllers, animated: true)
    }
}
