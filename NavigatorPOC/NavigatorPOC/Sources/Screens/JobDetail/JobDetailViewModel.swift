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
    private let jobDetailFlow = JobDetailFlow()
    
    init(jobId: String){
        self.jobId = jobId
        didTapApply.sink { [weak self] _ in
            self?.jobDetailFlow.navigate(to: .shiftApplicationSkills)
        }.store(in: &subscriptions)
    }
}
