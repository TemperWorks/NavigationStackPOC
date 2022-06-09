//
//  ShiftOverviewViewModel.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 27/05/2022.
//

import Foundation
import Combine

class ShiftOverviewViewModel {
	
    var didTapShowJobAtIndex = PassthroughSubject<Int, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
	init(showJobHandler: @escaping (String) -> ()) {
        didTapShowJobAtIndex.sink { _ in
            showJobHandler("fakeId")
        }.store(in: &subscriptions)
    }
}

import UIKit

extension ShiftOverviewViewModel: Screen {
	func viewController() -> UIViewController {
		ShiftOverviewViewController(viewModel: self)
	}
}
