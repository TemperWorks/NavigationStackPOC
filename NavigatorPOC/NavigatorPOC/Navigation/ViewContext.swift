import UIKit

protocol ViewContext {
	var rootViewController: UIViewController { get }
    var topMostViewController: UIViewController? { get }
    var tabBarController: UITabBarController? { get }
    var currentNavigationController: UINavigationController? { get }
}

extension ViewContext {
	
    var topMostViewController: UIViewController? {
        return rootViewController.topMostViewController
    }
    
    var tabBarController: UITabBarController? {
        return rootViewController.tabBarController
    }
    
    var currentNavigationController: UINavigationController? {
        return rootViewController.currentNavigationController
    }
}

// MARK: - Private

fileprivate extension UIViewController {
    
    var topMostViewController: UIViewController {
        if let presented = self.presentedViewController {
            return presented.topMostViewController
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController ?? tab
        }
        
        return self
    }
    
    var tabBarController: UITabBarController? {
        if let presented = self.presentedViewController {
            return presented.tabBarController
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.tabBarController
        }
        
        if let tabController = self as? UITabBarController {
            return tabController
        }
        
        return nil
    }
    
    var currentNavigationController: UINavigationController? {
        
        if let presented = self.presentedViewController {
            return presented.currentNavigationController
        }
        
        if let navigation = self as? UINavigationController {
            return navigation
        }
        
        return nil
    }
}


