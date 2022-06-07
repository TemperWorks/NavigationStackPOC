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
    
    init() {
        didTapShowJobAtIndex.sink { _ in
            let screen = Screen.jobDetail(id: "fakeId")
            AppEnvironment.Current.navigator.handle(navigation: .modal(screen, isEmbeddedInNavigation: true))
        }.store(in: &subscriptions)
    }
}
