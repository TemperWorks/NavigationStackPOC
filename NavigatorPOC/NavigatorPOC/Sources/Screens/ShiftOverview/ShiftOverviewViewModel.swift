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
    private let shiftOverviewFlow = ShiftOverviewFlow()
    
    init() {
        didTapShowJobAtIndex.sink { [weak self] _ in
            self?.shiftOverviewFlow.navigate(to: .jobDetail(id: "fakeId"))
        }.store(in: &subscriptions)
    }
}
