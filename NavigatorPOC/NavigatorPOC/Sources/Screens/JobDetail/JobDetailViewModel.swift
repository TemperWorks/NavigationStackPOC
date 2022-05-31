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

    init(jobId: String){
        self.jobId = jobId
        didTapApply.sink { _ in
            let screen = Screen.shiftApplicationSkills(shiftId: "fakeShiftId")
            AppEnvironment.Current.navigator.handle(navigation: .modal(screen, isEmbededInNavigation: true))
        }.store(in: &subscriptions)
    }
}
