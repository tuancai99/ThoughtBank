//
//  FeedView.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Contributors:
//  [YOUR NAME HERE]
//
//  --- NOTE ---
//  This view should only deal with UI logic.
//  Actual data logic should be handled in CentralViewModel.
//

import SwiftUI

struct MainFeedView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<viewModel.feedThoughts.count, id: \.self) { i in
                    ThoughtCard(thought: viewModel.feedThoughts[viewModel.feedThoughts.count - i - 1])
                        .offset(x: CGFloat(i), y: CGFloat(i))
                }
            }
            .padding(EdgeInsets(top: 96, leading: 32, bottom: 64, trailing: 32))
            .offset(x:-8,y:-40)
            HStack (spacing: 40) {
                RoundedButton(text: "Reject", image: "chevron.left", size: 8, action: {
                    print("Reject")
                    viewModel.goToNextThought()
                })
                RoundedButton(text: "Add Thought", image: "plus", size: 30, action: {
                    print("Add Thought")
                    // Present modal for AddThoughtsView
                })
                RoundedButton(text: "Deposit", image: "chevron.right", size: 8, action: {
                    print("Deposit")
                    viewModel.depositThought(thought: viewModel.currentFeedThought)
                    viewModel.goToNextThought()
                })
            }
            .offset(y:0)
        }
    }
}

struct MainFeedView_Previews: PreviewProvider {
    static var previews: some View {
        MainFeedView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
