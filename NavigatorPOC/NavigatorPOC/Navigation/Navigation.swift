//
//  Navigation.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 14/5/22.
//

import Foundation
import UIKit

public enum Navigation {
    case root(Screen)
    case tab(Int)
    case push(Screen)
    case modal(
        Screen,
        style: UIModalPresentationStyle = .automatic,
        isEmbeddedInNavigation: Bool = false,
        completion: (() -> Void)? = nil
    )
}

public struct Screen {
    let viewController: () -> UIViewController
}
