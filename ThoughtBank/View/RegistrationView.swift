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
    @State private var didClickButton: Bool = false
    
    var body: some View {
        ZStack {
            VStack () {
                Image("Logo").padding(.bottom,-20)
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("Register").font(Font.custom("SmoochSans-SemiBold", size: 80))
                    Text("Provide your email and a password to get started")
                }.padding(.vertical, 10)
                
                ImageTextField(text: $email, placeholder: "Email", image: "user-symbol")
                ImageTextField(text: $password, placeholder: "Password", image: "password-symbol", secure: true)
                
                LargeFilledButton(text: "Register", color: .pink, action: {
                    didClickButton = true
                    viewModel.createUser(email: email, password: password)
                })
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                HStack {
                    Text("Already have an account?")
                    Button(action: {
                        viewModel.navigationState = .login
                    }, label: {
                        Text("Sign in")
                    })
                    .tint(.pink)
                }
            }
            ZStack {
                if didClickButton {
                    Rectangle()
                        .fill(Color.black).opacity(0.6)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
        }
        .font(Font.custom("Poppins-Regular", size: 14))
        .padding(16)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
