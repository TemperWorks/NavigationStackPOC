//
//  NavigatorSpy.swift
//  NavigatorPOCTests
//
//  Created by Alejandro Luján López on 17/5/22.
//

import Foundation
import NavigatorPOC

class NavigatorSpy: Navigator {

    var handledNavigation: Destination?
    
    override func handle(navigation: Destination, animated: Bool = true) {
        handledNavigation = navigation
    }
}
