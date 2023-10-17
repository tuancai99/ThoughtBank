//
//  FeedView.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  View for main feed.
//
//  --- NOTE ---
//  This view should only deal with UI logic.
//  Actual data logic should be handled in CentralViewModel.
//

import SwiftUI

struct MainFeedView<ViewModel: ViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.viewModelDescription)
    }
}

struct MainFeedView_Previews: PreviewProvider {
    static var previews: some View {
        MainFeedView(viewModel: PreviewViewModel())
    }
}
