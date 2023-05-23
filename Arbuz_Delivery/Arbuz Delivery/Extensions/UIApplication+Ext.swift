import UIKit

extension UIApplication {
    
    public static var mainKeyWindow: UIWindow? {
        if let activeScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            return activeScene.windows.first(where: { $0.isKeyWindow })
        }
        return UIWindow()
    }

    public static var rootViewController: UIViewController? {
        guard let keyWindow = mainKeyWindow, let rootViewController = keyWindow.rootViewController else {
            return nil
        }
        return rootViewController
    }

    public static func topViewController(controller: UIViewController? = rootViewController) -> UIViewController? {
        if controller == nil {
            return topViewController(controller: rootViewController)
        }
            
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }

        if let tabController = controller as? UITabBarController {
            if let selectedViewController = tabController.selectedViewController {
                return topViewController(controller: selectedViewController)
            }
        }

        if let presentedViewController = controller?.presentedViewController {
            return topViewController(controller: presentedViewController)
        }
        return controller
    }
}
