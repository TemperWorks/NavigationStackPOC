//
//  OnboardingViewModel.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 27/05/2022.
//

import Foundation
import Combine
import UIKit

class OnboardingViewModel {
	
    var didTapNext = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
	let title: String
	
	init(title: String, nextHandler: @escaping () -> Void) {
		self.title = title
        didTapNext.sink { _ in
            nextHandler()
        }.store(in: &cancellables)
    }
}

extension OnboardingViewModel: Screen {
	func viewController() -> UIViewController {
		let result = OnboardingViewController(viewModel: self)
		result.title = title
		return result
	}
}
