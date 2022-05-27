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
    
    init(shiftId: String){
        self.shiftId = shiftId
        didTapApply.sink { _ in
            let screen = Screen.shiftOverviewTabBar()
            AppEnvironment.Current.navigator.handle(navigation: .root(screen))
        }.store(in: &subscriptions)
    }
}
