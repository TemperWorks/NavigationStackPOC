//
//  ExploreNavigator.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 14/5/22.
//

import Foundation
import UIKit
import Combine

class ExploreNavigator: Navigator {
    
    enum Destination {
        case shiftOverview
    }
    
    weak var navigationController: UINavigationController?
    weak var appNavigator: AppNavigator?
    
    var subscriptions = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, appNavigator: AppNavigator) {
        self.navigationController = navigationController
        self.appNavigator = appNavigator
    }
    
    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func start() {
        self.navigate(to: .shiftOverview)
    }
    
    private func makeViewController(for destination: Destination) -> UIViewController {
        let viewModel = POCViewModel()
        viewModel.didTapNext.sink { _ in
            // ⚠️ WE HAVE A PROBLEM HERE TO PRESENT AS MODAL, `navigate` always pushes into the navigation stack
            print("⚠️ WE HAVE A PROBLEM HERE TO PRESENT AS MODAL, `navigate` always pushes into the navigation stack")
        }.store(in: &subscriptions)
        return ShiftOverviewViewController(viewModel: viewModel)
    }
}
