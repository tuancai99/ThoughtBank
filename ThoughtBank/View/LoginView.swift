//
//  LoginView.swift
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

struct LoginView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            AuthenticationView<ViewModel>(
                type: "Login",
                instruction: "Hello again, sign-in to view thoughts:",
                question: "Don't have an account?",
                alternativeAction: "Register",
                alternativeDestination: .registration,
                authenticationProcedure: viewModel.login, email: $email,
                password: $password)
           
            ProgressOverlay(isVisible: $viewModel.shouldLoadBlocking)
        }
        .onAppear() {
            if let credentials = Preferences.loadCredentials() {
                email = credentials.email
                password = credentials.password
                viewModel.login(email: email, password: password)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}


