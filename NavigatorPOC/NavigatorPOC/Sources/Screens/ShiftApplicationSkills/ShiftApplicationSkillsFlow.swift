//
//  ShiftApplicationSkillsFlow.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 31/05/2022.
//

import Foundation

struct ShiftApplicationSkillsFlow: Flow {
    
    enum Destination {
        case shiftApplicationVAT(id: String)
    }
    
    func navigate(to destination: Destination) {
        switch destination {
        case .shiftApplicationVAT(let id):
            let screen = Screen.shiftApplicationVAT(shiftId: id)
            AppEnvironment.Current.navigator.handle(navigation:.push(screen))
        }
    }
}
