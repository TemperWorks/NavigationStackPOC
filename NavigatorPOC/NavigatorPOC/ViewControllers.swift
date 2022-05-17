//
//  ViewControllers.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 14/5/22.
//

import Foundation
import UIKit
import SnapKit
import Combine

class OnboardingViewModel {
    var didTapNext = PassthroughSubject<Void, Never>()
    private var subscriptions = Set<AnyCancellable>()
    private var onboardingFlow: OnboardingFlow
    
    init(onboardingFlow: OnboardingFlow = .development) {
        self.onboardingFlow = onboardingFlow
        
        didTapNext.sink { _ in
            Task {
                let nextNavigation = await onboardingFlow.getNextNavigation()
                await AppEnvironment.Current.navigator.handle(navigation: nextNavigation)
            }
        }.store(in: &subscriptions)
    }
}

class OnboardingViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Next Screen", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.backgroundColor = UIColor.green
        return button
    }()
    
    let viewModel: OnboardingViewModel
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = String(describing: type(of: self).self)
        self.navigationController?.isNavigationBarHidden = false
        setUp()
    }
    
    private func setUp() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
        }
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        viewModel.didTapNext.send()
    }
}

class EmailViewController: OnboardingViewController {}

class PasswordViewController: OnboardingViewController {}

class PhoneNumberViewController: OnboardingViewController {}

class IDVerificationViewController: OnboardingViewController {}


class ShiftOverviewViewModel {
    var didTapShowJobAtIndex = PassthroughSubject<Int, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        didTapShowJobAtIndex.sink { _ in
            let screen = Screen.jobDetail(id: "fakeId").embededInNavigationController()
            Task {
                await AppEnvironment.Current.navigator.handle(navigation: .modal(screen))
            }
        }.store(in: &subscriptions)
    }
}

class ShiftOverviewViewController: UIViewController {

    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Show Job Detail", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.backgroundColor = UIColor.cyan
        return button
    }()

    let viewModel: ShiftOverviewViewModel
    
    init(viewModel: ShiftOverviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Explore", image: .init(systemName: "globe.europe.africa"), selectedImage: .init(systemName: "globe.europe.africa.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Explore"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = String(describing: type(of: self).self)
        self.navigationController?.isNavigationBarHidden = false
        setUp()
    }
    
    private func setUp() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
        }
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        viewModel.didTapShowJobAtIndex.send(0)
    }
}

class ProfileViewModel {
    var didTapLogout = PassthroughSubject<Int, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    private var onboardingFlow: OnboardingFlow
    
    init(onboardingFlow: OnboardingFlow = .development) {
        self.onboardingFlow = onboardingFlow
        
        didTapLogout.sink { _ in
            onboardingFlow.simulateLogout()
            Task {
                let navigation = await onboardingFlow.getFirstNavigation()
                await AppEnvironment.Current.navigator.handle(navigation: navigation)
            }
        }.store(in: &subscriptions)
    }
}

class ProfileViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.backgroundColor = UIColor.cyan
        return button
    }()
    
    let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Profile", image: .init(systemName: "person"), selectedImage: .init(systemName: "person.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = String(describing: type(of: self).self)
        self.navigationController?.isNavigationBarHidden = false
        setUp()
    }
    
    private func setUp() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
        }
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        viewModel.didTapLogout.send(0)
    }
}


class JobDetailViewModel {
    var jobId: String
    var didTapApply = PassthroughSubject<Void, Never>()
    private var subscriptions = Set<AnyCancellable>()

    init(jobId: String){
        self.jobId = jobId
        didTapApply.sink { _ in
            let screen = Screen.shiftApplicationSkills(shiftId: "fakeShiftId")
                            .embededInNavigationController()
            Task {
                await AppEnvironment.Current.navigator.handle(navigation:.modal(screen))
            }
        }.store(in: &subscriptions)
    }
}

class JobDetailViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Apply For Shift", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.backgroundColor = UIColor.cyan
        return button
    }()
    
    let viewModel: JobDetailViewModel
    
    init(viewModel: JobDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.navigationItem.title = String(describing: type(of: self).self)
        self.navigationController?.isNavigationBarHidden = false
        setUp()
    }
    
    private func setUp() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
        }
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        viewModel.didTapApply.send()
    }
}


class ShiftApplicationVATViewModel {
    var shiftId: String
    var didTapApply = PassthroughSubject<Void, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    init(shiftId: String){
        self.shiftId = shiftId
        didTapApply.sink { _ in
            let screen = Screen.shiftOverviewTabBar()
            Task {
                await AppEnvironment.Current.navigator.handle(navigation: .root(screen))
            }
        }.store(in: &subscriptions)
    }
}

class ShiftApplicationVATViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("I have a VAT", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.backgroundColor = UIColor.cyan
        return button
    }()
    
    let viewModel: ShiftApplicationVATViewModel
    
    init(viewModel: ShiftApplicationVATViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = String(describing: type(of: self).self)
        self.navigationController?.isNavigationBarHidden = false
        setUp()
    }
    
    private func setUp() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
        }
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        viewModel.didTapApply.send()
    }
}

class ShiftApplicationSkillsViewModel {
    var shiftId: String
    var didTapApply = PassthroughSubject<Void, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    init(shiftId: String){
        self.shiftId = shiftId
        didTapApply.sink { _ in
            let screen = Screen.shiftApplicationVAT(shiftId: shiftId)
            Task {
                await AppEnvironment.Current.navigator.handle(navigation:.push(screen))
            }
        }.store(in: &subscriptions)
    }
}

class ShiftApplicationSkillsViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("I have all the skills", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.backgroundColor = UIColor.cyan
        return button
    }()
    
    let viewModel: ShiftApplicationSkillsViewModel
    
    init(viewModel: ShiftApplicationSkillsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = String(describing: type(of: self).self)
        self.navigationController?.isNavigationBarHidden = false
        setUp()
    }
    
    private func setUp() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
        }
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        viewModel.didTapApply.send()
    }
}
