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
            if let user = viewModel.user {
                thoughtsView
                .padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
                Spacer()
                buttonStack
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32))
            } else {
                Spacer()
                Text("We're having trouble loading your data.")
                    .bold()
                LargeFilledButton(text: "Sign in", color: .pink, action: {
                    print("MainFeedView --> setScreen(.login)")
                    viewModel.setScreen(to: .login)
                })
                .padding()
                Spacer()
            }
        }
        .onAppear(perform: {
            print("MainFeedView --> (blocking) updateFeedThoughts()")
            viewModel.shouldLoadBlocking = true
            viewModel.updateFeedThoughts()
            viewModel.shouldLoadBlocking = false
        })
    }
    
    var thoughtsView: some View {
        ThoughtsView<ViewModel>(
            thoughtIndex: $viewModel.feedThoughtIndex,
            thoughts: $viewModel.feedThoughts,
            refreshAction: {
                print("MainFeedView --> (blocking) updateFeedThoughts()")
                viewModel.shouldLoadBlocking = true
                viewModel.updateFeedThoughts()
                viewModel.shouldLoadBlocking = false
            },
            horizontalLineColor: .blue,
            verticalLineColor: .red,
            onNext: onNext
        )
    }
    
    var buttonStack: some View {
        HStack {
            Spacer()
            RoundedButton(text: "Reject", image: "xmark", size: 18, action: {
                print("MainFeedView --> goToNextFeedThought()")
                viewModel.goToNextFeedThought()
            })
            Spacer()
            Spacer()
            RoundedButton(text: "Deposit", image: "checkmark", size: 18, action: {
                print("MainFeedView --> depositThought()")
                viewModel.depositThought()
            })
            Spacer()
        }
        .padding(.bottom, 12)
        .padding(.top, 12)
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
