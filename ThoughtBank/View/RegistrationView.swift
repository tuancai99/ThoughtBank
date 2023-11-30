//
//  RegistrationView.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Contributors:
//  [YOUR NAME HERE]
//
//  --- NOTE ---
//  This view should only deal with UI logic.
//  Actual data logic should be handled in CentralViewModel.
//

import SwiftUI

struct RegistrationView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    init() {
        // jump to login screen if user credentials saved
        if let _ = Preferences.loadCredentials() {
            viewModel.navigationState = .login
        }
    }
    
    var body: some View {
        ZStack {
            
            AuthenticationView<ViewModel>(
                type: "Register",
                instruction: "Provide your email and a password to get started:",
                question: "Already have an account?",
                alternativeAction: "Sign in",
                alternativeDestination: .login,
                authenticationProcedure: viewModel.createUser, 
                email: $email,
                password: $password)
            
            ProgressOverlay(isVisible: $viewModel.shouldLoadBlocking)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
