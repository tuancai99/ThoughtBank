//
//  ThoughtBankApp.swift
//  ThoughtBank
//
//  Created by Abdulaziz Albahar on 10/17/23.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct ThoughtBankApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            ManagerView<CentralViewModel>()
                .environmentObject(CentralViewModel())
                .environment(\.font, Font.custom("Poppins-Regular", size: 14))
        
        }
    }
}
