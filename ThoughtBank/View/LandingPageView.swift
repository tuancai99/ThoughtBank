//
//  LandingPageView.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  View for landing page.
//
//  --- NOTE ---
//  This view should only deal with UI logic.
//  Actual data logic should be handled in CentralViewModel.
//

import SwiftUI

struct LandingPageView<ViewModel: ViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.description)
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView(viewModel: PreviewViewModel())
    }
}
