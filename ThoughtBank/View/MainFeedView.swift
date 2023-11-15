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
        ZStack {
            ZStack {
                ForEach(0..<viewModel.feedThoughts.count, id: \.self) { i in
                    ThoughtCard(thought: viewModel.feedThoughts[viewModel.feedThoughts.count - i - 1])
                        .offset(x: CGFloat(i), y: CGFloat(i))
                }
            }
            .padding(EdgeInsets(top: 64, leading: 32, bottom: 144, trailing: 32))
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    RoundedButton(text: "Reject", image: "xmark", size: 16, action: {
                        // TODO: Implement "Reject" button
                        // - If the user is rejecting, what's the sole action we need to take?
                        print("Call viewModel to go to the next thought")
                        viewModel.goToNextThought()
                    })
                    Spacer()
                    RoundedButton(text: "Deposit", image: "checkmark", size: 16, action: {
                        // TODO: Implement "Deposit" button
                        // - We need to make a call to the viewModel so that the Thought
                        //   is saved in User's deposited thoughts
                        // - We also need to show the next card
                        print("Call viewModel to deposit the current thought and go to the next thought")
                        viewModel.depositThought(thought: viewModel.currentFeedThought)
                        viewModel.goToNextThought()
                    })
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 48, trailing: 32))
            }
        }
    }
}

struct MainFeedView_Previews: PreviewProvider {
    static var previews: some View {
        MainFeedView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
