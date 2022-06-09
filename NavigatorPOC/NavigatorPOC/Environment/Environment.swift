//
//  Environment.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 15/5/22.
//

import Foundation
import Combine

public struct Environment {
	public var session: CurrentValueSubject<Session?, Never> = .init(nil)
}

public struct Session {}
