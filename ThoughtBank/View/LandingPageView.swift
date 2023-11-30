//
//  LandingPageView.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Contributors:
//  [Soham Shetty]
//
//  View for landing page.
//
//  --- NOTE ---
//  This view should only deal with UI logic.
//  Actual data logic should be handled in CentralViewModel.
//

import SwiftUI

struct LandingPageView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text("See what the \n world is thinking")
                    .font(
                        Font.custom("SmoochSans-ExtraBold", size: 64)
                    )
                    .kerning(0.35)
                    .foregroundStyle(.primary)
                    .padding(.bottom, 30)
                
                
                LargeFilledButton(text: "Create account", color: .pink) {
                    
                    withAnimation {
                        print("LandingPageView --> setScreen(.registration)")
                        viewModel.setScreen(to: .registration)
                    }
                }
            }
            .padding(.bottom, 80)
                                    
            TextButtonPair<ViewModel>(question: "Already have an account?", buttonText: "Sign in", destination: .login)
            
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(16)
        .onAppear() {
            if let _ = Preferences.loadCredentials() {
                viewModel.navigationState = .login
            }
        }
    }
    
}

struct TextButtonPair<VM: ViewModelProtocol>: View {
    
    @EnvironmentObject var viewModel: VM
    
    var question: String
    var buttonText: String
    var destination: NavigationState
    
    var body: some View {
        HStack {
            Text(question)
            Button(action: {
                withAnimation {
                    print("TextButtonPair --> setScreen()")
                    viewModel.setScreen(to: destination)
                }
            }, label: {
                Text(buttonText)
                    .fontWeight(.semibold)
                    .tint(.pink)
            })
        }
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
