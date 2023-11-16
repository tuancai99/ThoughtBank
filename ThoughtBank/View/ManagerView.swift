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
            
        case .login:
            LoginView<ViewModel>()
            
        case .registration:
            RegistrationView<ViewModel>()
        case .feedThoughts, .depositedThoughts, .ownedThoughts, .settings, .add:
            MainView<ViewModel>()
        }
    }
}

struct ManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ManagerView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
