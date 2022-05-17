//
//  OnboardingFlowTests.swift
//  NavigatorPOCTests
//
//  Created by Alejandro Luján López on 17/5/22.
//

import SnapshotTesting
import XCTest
@testable import NavigatorPOC

class OnboardingFlowTests: XCTestCase {

    /// Test sample spying the navigation
    ///
    /// - Important: The first time the snapshot test will fail cause it does not have a snapshot saved to disk yet. The second time it should pass
    func test_OnboardingViewModel_WhenOnboardingCompleted_navigatesToShiftOverviewTabController() {
        let navigatorSpy = NavigatorSpy()
        AppEnvironment.Current.navigator = navigatorSpy
        OnboardingFlow().simulateCompletion()
        let viewModel = OnboardingViewModel()
        viewModel.didTapNext.send(())
        
        assertSnapshot(matching: navigatorSpy.handledNavigation, as: .dump)
    }

}
