//
//  Navigator.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 14/5/22.
//

import Foundation
import UIKit

open class Navigator: ViewContext {
	var rootViewController: UIViewController
	
	public init(_ rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}
	
	open func handle(navigation: Destination, animated: Bool = true) {
		DispatchQueue.main.async {
			switch navigation {
				case .tab(let index):
					self.tabBarController?.selectedIndex = index
					
				case .modal(let screen, let presentationStyle, let isEmbeddedInNavigation, let completion):
					
					let viewController = isEmbeddedInNavigation ? screen.embeddedInNavigationController() : screen.viewController()
					
					viewController.modalPresentationStyle = presentationStyle
					self.topMostViewController?.present(
						viewController,
						animated: animated,
						completion: completion
					)
					
				case .push(let screen):
					let viewController = screen.viewController()
					self.currentNavigationController?.pushViewController(
						viewController,
						animated: animated
					)
				case .root(let screen):
					let viewController = screen.viewController()
					self.rootViewController = viewController
			}
		}
	}
}

fileprivate extension Screen {
	
	func embeddedInNavigationController() -> UIViewController {
		let viewController = self.viewController()
		return UINavigationController(rootViewController: viewController)
	}
	
}
