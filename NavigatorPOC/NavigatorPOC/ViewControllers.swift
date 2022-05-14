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

class POCViewModel {
    var didTapNext = PassthroughSubject<Void, Never>()
}

class POCViewController: UIViewController {
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = String(describing: type(of: self).self)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Next Screen", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.backgroundColor = UIColor.green
        return button
    }()
    
    lazy var stackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    let viewModel: POCViewModel
    
    init(viewModel: POCViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setUp()
    }
    
    private func setUp() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        viewModel.didTapNext.send()
    }
}

class EmailViewController: POCViewController {}

class PasswordViewController: POCViewController {}

class PhoneNumberViewController: POCViewController {}

class IDVerificationViewController: POCViewController {}

class ShiftOverviewViewController: POCViewController {}
