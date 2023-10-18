//
//  LandingPageView.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Contributors:
//  [YOUR NAME HERE]
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
        Text(viewModel.description)
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
