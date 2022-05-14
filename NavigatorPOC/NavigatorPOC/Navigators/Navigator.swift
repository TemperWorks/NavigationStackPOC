//
//  Navigator.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 13/5/22.
//

import Foundation

protocol Navigator {
    associatedtype Destination
    
    func navigate(to destination: Destination)
}
