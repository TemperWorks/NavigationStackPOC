//
//  ProfileViewModel.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 27/05/2022.
//

import Foundation
import Combine

class ProfileViewModel {
    var didTapLogout = PassthroughSubject<Int, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    private let profileFlow = ProfileFlow()
    
    init() {
        didTapLogout.sink { _ in
            self.profileFlow.navigate(to: .logout)
            
        }.store(in: &subscriptions)
    }
}
