//
//  NavigatorSpy.swift
//  NavigatorPOCTests
//
//  Created by Alejandro Luján López on 17/5/22.
//

import Foundation
import NavigatorPOC

class NavigatorSpy: Navigator {

    var handledNavigation: Navigation?
    
    override func handle(navigation: Navigation, animated: Bool = true) {
        handledNavigation = navigation
    }
}
