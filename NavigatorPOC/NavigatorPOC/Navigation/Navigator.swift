//
//  Navigator.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 14/5/22.
//

import Foundation
import UIKit

open class Navigator {
    
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
                window.tabBarController?.selectedIndex = index
                
            case .modal(let screen, let presentationStyle, let completion):
                let vc = screen.viewController()
                vc.modalPresentationStyle = presentationStyle
                window.topMostViewController?.present(
                    vc,
                    animated: animated,
                    completion: completion
                )
                
            case .push(let screen):
                let vc = screen.viewController()
                window.currentNavigationController?.pushViewController(
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

