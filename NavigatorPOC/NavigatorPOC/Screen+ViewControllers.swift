//
//  Screen+ViewControllers.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 15/5/22.
//

import Foundation
import UIKit

extension Screen {
    
    static func email() -> Self {
        return .init {
            let viewModel = OnboardingViewModel()
            let vc = EmailViewController(viewModel: viewModel)
            return vc
        }
    }
    
    static func password() -> Self {
        return .init {
            let viewModel = OnboardingViewModel()
            let vc = PasswordViewController(viewModel: viewModel)
            return vc
        }
    }
    
    
    static func phone() -> Self {
        return .init {
            let viewModel = OnboardingViewModel()
            let vc = PhoneNumberViewController(viewModel: viewModel)
            return vc
        }
    }
    
    static func idVerification() -> Self {
        return .init {
            let viewModel = OnboardingViewModel()
            let vc = IDVerificationViewController(viewModel: viewModel)
            return vc
        }
    }
    
    static func shiftsOverview() -> Self {
        return .init {
            let vc = ShiftOverviewViewController(viewModel: ShiftOverviewViewModel())
            return vc
        }
    }
    
    static func profile() -> Self {
        return .init {
            let vc = ProfileViewController(viewModel: ProfileViewModel())
            return vc
        }
    }
    static func jobDetail(id: String) -> Self {
        return .init {
            let viewModel = JobDetailViewModel(jobId: id)
            let vc = JobDetailViewController(viewModel: viewModel)
            return vc
        }
    }
    
    static func shiftApplicationVAT(shiftId: String) -> Self {
        return .init {
            let viewModel = ShiftApplicationVATViewModel(shiftId: shiftId)
            let vc = ShiftApplicationVATViewController(viewModel: viewModel)
            return vc
        }
    }
    
    static func shiftApplicationSkills(shiftId: String) -> Self {
        return .init {
            let viewModel = ShiftApplicationSkillsViewModel(shiftId: shiftId)
            let vc = ShiftApplicationSkillsViewController(viewModel: viewModel)
            return vc
        }
    }
    
    static func shiftOverviewTabBar() -> Self {
        return .init {
            let tabBarVC = UITabBarController()
            tabBarVC.viewControllers = [shiftsOverview().viewController(),
                                        profile().viewController()]
            return tabBarVC
        }
    }
}

extension Screen {
    
    func embededInNavigationController() -> Screen {
        return .init {
            let vc = self.viewController()
            return UINavigationController(rootViewController: vc)
        }
    }
}
