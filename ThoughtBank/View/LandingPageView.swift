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
        VStack(){
            Image("Logo")
            VStack(){
                Text("See what the \n world is thinking")
                    .font(
                        Font.custom("SmoochSans-ExtraBold", size: 64)
                    )
                    .kerning(0.35)
                    .foregroundStyle(.primary)
                
                LargeFilledButton(text: "Create account", color: .pink, action: {
                    viewModel.navigationState = .registration
                })
                .padding(EdgeInsets(top: -32, leading: 0, bottom: 0, trailing: 0))
            }
            Spacer()
            HStack {
                Text("Already have an account?")
                Button(action: {
                    viewModel.navigationState = .login
                }, label: {
                    Text("Sign in")
                })
            }
        }
        .padding(16)
        .font(Font.custom("Poppins-Regular", size: 14))
    }
    
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
