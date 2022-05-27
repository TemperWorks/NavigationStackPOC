//
//  OnboardingViewController.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 27/05/2022.
//

import Foundation
import UIKit

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

// MARK: - Assuming other onboarding screens

class EmailViewController: OnboardingViewController {}

class PasswordViewController: OnboardingViewController {}

class PhoneNumberViewController: OnboardingViewController {}

class IDVerificationViewController: OnboardingViewController {}
