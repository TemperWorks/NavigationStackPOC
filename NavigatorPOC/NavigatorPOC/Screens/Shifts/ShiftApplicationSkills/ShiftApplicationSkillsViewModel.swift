//
//  ShiftApplicationSkillsViewModel.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 27/05/2022.
//

import Foundation
import Combine

class ShiftApplicationSkillsViewModel {
    var shiftId: String
    var didTapApply = PassthroughSubject<Void, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
	init(shiftId: String, applyHandler: @escaping (String) -> ()){
        self.shiftId = shiftId
        didTapApply.sink { _ in
			applyHandler(shiftId)
        }.store(in: &subscriptions)
    }
}

import UIKit

extension ShiftApplicationSkillsViewModel: Screen {
	func viewController() -> UIViewController {
		ShiftApplicationSkillsViewController(viewModel: self)
	}
}
