//
//  Environment.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 15/5/22.
//

import Foundation
public struct Environment {
    public var navigator: Navigator
    
    public init(navigator: Navigator = Navigator()) {
        self.navigator = navigator
    }
}
