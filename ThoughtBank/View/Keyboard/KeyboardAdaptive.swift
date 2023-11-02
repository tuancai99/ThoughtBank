//
//  KeyboardAdaptive.swift
//  KeyboardAvoidanceSwiftUI
//
//  Created by Vadim Bulavin on 3/27/20.
//  Copyright © 2020 Vadim Bulavin. All rights reserved.
//

import UIKit
import Combine

/// Note that the `KeyboardAdaptive` modifier wraps your view in a `GeometryReader`,
/// which attempts to fill all the available space, potentially increasing content view size.
///

class KeyboardAdaptive: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0

    init() {
        self.listenForKeyboardNotifications()
    }
    
    private func listenForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
                                                guard let userInfo = notification.userInfo,
                                                    let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                                                
                                                self.keyboardHeight = keyboardRect.height
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
                                                self.keyboardHeight = 0
        }
    }
}

