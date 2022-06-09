//
//  JobDetailViewModel.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 27/05/2022.
//

import Foundation
import Combine

class JobDetailViewModel {
    var jobId: String
    var didTapApply = PassthroughSubject<Void, Never>()
    private var subscriptions = Set<AnyCancellable>()

	init(jobId: String, startApplicationHandler: @escaping (String) -> ()) {
        self.jobId = jobId
        didTapApply.sink { _ in
			startApplicationHandler(jobId)
        }.store(in: &subscriptions)
    }
}

import UIKit

extension JobDetailViewModel: Screen {
	func viewController() -> UIViewController {
		JobDetailViewController(viewModel: self)
	}
}
