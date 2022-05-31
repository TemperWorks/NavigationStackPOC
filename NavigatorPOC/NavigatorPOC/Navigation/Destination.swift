//
//  Destination.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 31/05/2022.
//

import Foundation

protocol Destination {
    associatedtype Destination
    func navigate(to destination: Destination)
}
