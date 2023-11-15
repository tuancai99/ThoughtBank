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
            LandingPageView<ViewModel>().environmentObject(viewModel)
        case .login:
            LoginView<ViewModel>().environmentObject(viewModel)
        case .registration:
            RegistrationView<ViewModel>().environmentObject(viewModel)
        case .feedThoughts, .depositedThoughts, .ownedThoughts, .settings, .add:
            MainView<ViewModel>().environmentObject(viewModel)
        }
    }
}

struct ManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ManagerView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
