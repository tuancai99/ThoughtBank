//
//  AuthenticationView.swift
//  ThoughtBank
//
//  Created by Abdulaziz Albahar on 11/25/23.
//

import SwiftUI

struct AuthenticationView<VM: ViewModelProtocol>: View {
    
    @EnvironmentObject var viewModel: VM
    
    let type: String
    let instruction: String
    let question: String
    let alternativeAction: String
    let alternativeDestination: NavigationState
    let authenticationProcedure: (String, String) -> Void
    
    @Binding var email: String
    @Binding var password: String

    var body: some View {
        VStack () {
                
            Text(type).font(Font.custom("SmoochSans-SemiBold", size: 80))
            
            Spacer()
            
            Text(instruction)
                .fontWeight(.regular)
                .frame(maxWidth: .infinity, alignment: .leading)
        
            ImageTextField(text: $email, placeholder: "Email", image: "person.fill")
            ImageTextField(text: $password, placeholder: "Password", image: "lock.fill", secure: true)
            
            LargeFilledButton(text: type, color: .pink, action: {
                
                // TODO: Implement "Register" button
                // - Must call viewModel (should be a straightforward call)
                withAnimation {
                    authenticationProcedure(email, password)
                }
                
            })
            
            Spacer()
            
            TextButtonPair<VM>(question: question, buttonText: alternativeAction, destination: alternativeDestination)

        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)

    }
}

#Preview {
    
    @StateObject var vm = PreviewViewModel()
    @State var email: String = ""
    @State var password: String = ""
    
    return AuthenticationView<PreviewViewModel>(type: "Register", instruction: "Provide your email and a password to get started:", question: "Already have an account?", alternativeAction: "Sign in", alternativeDestination: NavigationState.login, authenticationProcedure: vm.createUser, email: $email, password: $password)
        .environmentObject(vm)
}
