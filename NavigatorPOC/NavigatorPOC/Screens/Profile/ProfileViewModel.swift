//
//  ProfileViewModel.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 27/05/2022.
//

import Foundation
import Combine

public class ProfileViewModel {
    var didTapLogout = PassthroughSubject<Int, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
 
    init() {
        didTapLogout.sink { _ in
			AppEnvironment.Current.session.value = nil
        }.store(in: &subscriptions)
    }
}

import UIKit

extension ProfileViewModel: Screen {
	public func viewController() -> UIViewController {
		ProfileViewController(viewModel: self)
	}
}
