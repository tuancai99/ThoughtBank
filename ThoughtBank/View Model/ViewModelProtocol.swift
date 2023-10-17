//
//  ViewModelProtocol.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Define a view model's structure so that it can be implemented
//  by both the "live" CentralViewModel and the "dummy" PreviewViewModel.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    // indicates the type of VM we're looking at (for debugging purposes)
    var viewModelDescription: String { get set }
    
}
