//
//  JobFlow.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 31/05/2022.
//

import Foundation

struct JobDetailFlow: Destination {
    
    enum Destination {
        case shiftApplicationSkills
    }
    
    func navigate(to destination: Destination) {
        switch destination {
        case .shiftApplicationSkills:
            let screen = Screen.shiftApplicationSkills(shiftId: "fakeShiftId")
            AppEnvironment.Current.navigator.handle(navigation: .modal(screen, isEmbededInNavigation: true))
        }
    }
}
