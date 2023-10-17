//
//  LoginView.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  View for login page.
//
//  --- NOTE ---
//  This view should only deal with UI logic.
//  Actual data logic should be handled in CentralViewModel.
//

import SwiftUI

struct LoginView<ViewModel: ViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.description)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: PreviewViewModel())
    }
}
