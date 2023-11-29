//
//  ManagerView.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 11/14/23.
//

import SwiftUI

struct ManagerView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        switch viewModel.navigationState {
            
        case .landing:
            LandingPageView<ViewModel>()
                .transition(AnyTransition.move(edge: .trailing))

        case .login:
            LoginView<ViewModel>()
                .transition(AnyTransition.move(edge: .trailing))

        case .registration:
            RegistrationView<ViewModel>()
                .transition(AnyTransition.move(edge: .trailing))

        case .feedThoughts, .depositedThoughts, .ownedThoughts, .settings, .add:
            MainView<ViewModel>()
                .transition(AnyTransition.move(edge: .trailing))
        }
        
    }
}

struct ManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ManagerView<PreviewViewModel>().environmentObject(PreviewViewModel())
            .environment(\.font, Font.custom("Poppins-Regular", size: 14))
    }
}
