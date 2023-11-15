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
            VStack () {
                Image("Logo").padding(.bottom,-20)
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("Welcome").font(Font.custom("SmoochSans-SemiBold", size: 80))
                    Text("Hello again, login to view thoughts")
                }.padding(.vertical, 10)
                
                ImageTextField(text: $email, placeholder: "Email", image: "user-symbol")
                ImageTextField(text: $password, placeholder: "Password", image: "password-symbol", secure: true)
                
                LargeFilledButton(text: "Sign in", color: .pink, action: {
                    // TODO: Implement "Sign in" button
                    // - Must call viewModel (should be a straightforward call)
                    viewModel.login(email: email, password: password)
                })
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                HStack {
                    Text("Don't have an account?")
                    Button(action: {
                        // TODO: Transition to .registration navigation state
                        viewModel.navigationState = .registration
                    }, label: {
                        Text("Register")
                    })
                }
            }
            .padding(16)
            ProgressOverlay(isVisible: $viewModel.shouldLoadBlocking)
        }
        .font(Font.custom("Poppins-Regular", size: 14))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}


