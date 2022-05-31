//
//  ShiftApplicationSkillsViewModel.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 27/05/2022.
//

import Foundation
import Combine

class ShiftApplicationSkillsViewModel {
    var didTapApply = PassthroughSubject<Void, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    private let shiftApplicationSkillsFlow = ShiftApplicationSkillsFlow()
    
    init(shiftId: String){
        didTapApply.sink { [weak self] _ in
            self?.shiftApplicationSkillsFlow.navigate(to: .shiftApplicationVAT(id: shiftId))
        }.store(in: &subscriptions)
    }
}
