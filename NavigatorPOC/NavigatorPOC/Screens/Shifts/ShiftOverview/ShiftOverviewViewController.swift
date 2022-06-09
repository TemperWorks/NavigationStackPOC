//
//  ShiftOverviewViewController.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 27/05/2022.
//

import Foundation
import UIKit

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
