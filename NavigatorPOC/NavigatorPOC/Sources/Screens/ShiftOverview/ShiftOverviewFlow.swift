//
//  ShiftOverviewFlow.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 31/05/2022.
//

import Foundation

class ShiftOverviewFlow: Destination {
    
    enum Destination {
        case jobDetail(id: String)
    }
    
    func navigate(to destination: Destination) {
        switch destination {
        case .jobDetail(let id):
            let screen = Screen.jobDetail(id: id)
            AppEnvironment.Current.navigator.handle(navigation: .modal(screen, isEmbededInNavigation: true))
        }
    }
}
