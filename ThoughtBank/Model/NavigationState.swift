//
//  NavigationState.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 11/14/23.
//

import Foundation

enum NavigationState : String {
    case landing = "Welcome"
    case login = "Sign in"
    case registration = "Register"
    case feedThoughts = "Browse"
    case depositedThoughts = "Deposited"
    case ownedThoughts = "My Thoughts"
    case settings = "Settings"
    case add = "New Thought"
}
