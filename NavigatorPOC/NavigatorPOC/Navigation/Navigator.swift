//
//  Navigator.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 14/5/22.
//

import Foundation
import UIKit

open class Navigator: ViewContext {
    
    public weak var window: UIWindow?
    
    public init() {}
    
    public func configure(with window: UIWindow) {
        self.window = window
    }
    
    open func handle(navigation: Navigation, animated: Bool = true) {
        guard let window = window else {
            return
        }
        
        DispatchQueue.main.async {
            switch navigation {
            case .tab(let index):
                self.tabBarController?.selectedIndex = index
                
            case .modal(let screen, let presentationStyle, let isEmbeddedInNavigation, let completion):
                
                let vc = isEmbeddedInNavigation ? screen.embeddedInNavigationController().viewController() : screen.viewController()
                
                vc.modalPresentationStyle = presentationStyle
                self.topMostViewController?.present(
                    vc,
                    animated: animated,
                    completion: completion
                )
                
            case .push(let screen):
                let vc = screen.viewController()
                self.currentNavigationController?.pushViewController(
                    vc,
                    animated: animated
                )
            case .root(let screen):
                let vc = screen.viewController()
                window.rootViewController = vc
            }
        }
    }
}

fileprivate extension Screen {
    
    func embeddedInNavigationController() -> Screen {
        return .init {
            let vc = self.viewController()
            return UINavigationController(rootViewController: vc)
        }
    }
}
