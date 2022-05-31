//
//  ShiftApplicationVATViewModel.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 27/05/2022.
//

import Foundation
import Combine

class ShiftApplicationVATViewModel {
    var shiftId: String
    var didTapApply = PassthroughSubject<Void, Never>()
    private var subscriptions = Set<AnyCancellable>()
    private let shiftApplicationVATFlow = ShiftApplicationVATFlow()
    
    init(shiftId: String) {
        self.shiftId = shiftId
        didTapApply.sink { [weak self] _ in
            self?.shiftApplicationVATFlow.navigate(to: .main)
        }.store(in: &subscriptions)
    }
}
