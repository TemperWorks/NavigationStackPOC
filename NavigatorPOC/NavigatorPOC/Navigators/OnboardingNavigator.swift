//
//  OnboardingNavigator.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 14/5/22.
//

import Foundation
import UIKit
import Combine

class OnboardingNavigator: Navigator {
    
    enum Destination {
        case email
        case password
        case phoneNumber
        case IDVerification
    }
    
    weak var navigationController: UINavigationController?
    weak var appNavigator: AppNavigator?
    private var subscriptions = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, appNavigator: AppNavigator) {
        self.navigationController = navigationController
        self.appNavigator = appNavigator
    }
    
    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func start() {
        self.navigate(to: .email)
    }
    
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .email:
            let viewModel = POCViewModel()
            viewModel.didTapNext.sink { _ in
                self.navigate(to: .password)
            }.store(in: &subscriptions)
            return EmailViewController(viewModel: viewModel)
        case .password:
            let viewModel = POCViewModel()
            viewModel.didTapNext.sink { _ in
                self.navigate(to: .phoneNumber)
            }.store(in: &subscriptions)
            return PasswordViewController(viewModel: viewModel)
        case .phoneNumber:
            let viewModel = POCViewModel()
            viewModel.didTapNext.sink { _ in
                self.navigate(to: .IDVerification)
            }.store(in: &subscriptions)
            return PhoneNumberViewController(viewModel: viewModel)
        case .IDVerification:
            let viewModel = POCViewModel()
            viewModel.didTapNext.sink { [weak self] _  in
                self?.appNavigator?.navigate(to: .explore)
            }.store(in: &subscriptions)
            return IDVerificationViewController(viewModel: viewModel)
        }
    }
}
