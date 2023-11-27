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
        ScrollView {
            ZStack {
                if let user = viewModel.user {
                    ThoughtsView<ViewModel>(
                        thoughtIndex: $viewModel.feedThoughtIndex,
                        thoughts: $viewModel.feedThoughts,
                        onNext: onNext
                    )
                    .padding(EdgeInsets(top: 0, leading: 32, bottom: 144, trailing: 32))
                } else {
                    Text("User data is unavailable.")
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        RoundedButton(text: "Reject", image: "xmark", size: 16, action: {
                            // TODO: Implement "Reject" button
                            // - If the user is rejecting, what's the sole action we need to take?
                            print("Call viewModel to go to the next thought")
                            viewModel.goToNextFeedThought()
                        })
                        Spacer()
                        RoundedButton(text: "Deposit", image: "checkmark", size: 16, action: {
                            // TODO: Implement "Deposit" button
                            // - We need to make a call to the viewModel so that the Thought
                            //   is saved in User's deposited thoughts
                            // - We also need to show the next card
                            print("Call viewModel to deposit the current thought and go to the next thought")
                            viewModel.depositThought()
                        })
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 32, bottom: 48, trailing: 32))
                }
            }
            
        }.refreshable {
            viewModel.updateFeedThoughts()
        }
        .onAppear(perform: {
            viewModel.shouldLoadBlocking = true
            viewModel.updateFeedThoughts()
            viewModel.shouldLoadBlocking = false
        })
    }
    
    func onNext(current: Thought, first: Thought?, last: Thought?) -> Bool  {
        viewModel.goToNextFeedThought()
        return true
    }
    
    
}

struct MainFeedView_Previews: PreviewProvider {
    static var previews: some View {
        MainFeedView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
