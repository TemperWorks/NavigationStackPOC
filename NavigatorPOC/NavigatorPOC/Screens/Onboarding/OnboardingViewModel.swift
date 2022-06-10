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
	
	init(title: String, nextHandler: @escaping (MissingStepError?) -> Void) {
		self.title = title
        didTapNext.sink { _ in
			FakeProfileResource(missingStep: nextMissingStep())
				.get
				.sink { result in
					if case .failure(let error) = result {
						nextHandler(error)
					}
				} receiveValue: { _ in
					AppEnvironment.Current.session.value = .init()
					nextHandler(nil)
				}.store(in: &self.cancellables)
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
