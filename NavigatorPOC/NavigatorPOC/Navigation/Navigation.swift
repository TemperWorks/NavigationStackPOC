//
//  Navigation.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 14/5/22.
//

import Foundation
import UIKit

enum Navigation {
    case root(Screen)
    case section(Section)
    case push(Screen)
    case modal(
        Screen,
        UIModalPresentationStyle = .automatic,
        completion: (() -> Void)? = nil
    )
}

enum Section: Int {
    case home
    case messages
    case notifications
    case profile
}

struct Screen {
    let viewController: @MainActor () -> UIViewController
}
