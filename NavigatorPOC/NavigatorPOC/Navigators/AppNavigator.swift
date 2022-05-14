//
//  AppNavigator.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 13/5/22.
//

import Foundation
import UIKit


class AppNavigator: Navigator {
    
    enum Destination {
        case onboarding
        case explore
    }

    var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func navigate(to destination: Destination) {
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        switch destination {
        case .onboarding:
            let onboardingNavigator = OnboardingNavigator(navigationController: navigationController, appNavigator: self)
            onboardingNavigator.start()
        case .explore:
            let exploreNavigator = ExploreNavigator(navigationController: navigationController, appNavigator: self)
            exploreNavigator.start()
        }
    }
}
