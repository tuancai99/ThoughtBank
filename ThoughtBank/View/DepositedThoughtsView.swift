//
//  DepositedThoughtsView.swift
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

struct DepositedThoughtsView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            if let user = viewModel.user {
                ThoughtsView<ViewModel>(
                    thoughtIndex: $viewModel.depositedThoughtIndex,
                    thoughts: Binding(get: {user.depositedThoughts}, set: {user.depositedThoughts = $0}),
                    refreshAction: nil,
                    horizontalLineColor: .blue,
                    verticalLineColor: .purple,
                    onNext: onNext
                )
                .padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
                Spacer()
                buttonStack
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32))
            } else {
                Spacer()
                Text("We're having trouble loading your data.")
                    .bold()
                LargeFilledButton(text: "Sign in", color: .pink, action: {
                    print("DepositedThoughtsView --> setScreen(.login)")
                    viewModel.setScreen(to: .login)
                })
                .padding()
                Spacer()
            }
        }
    }
    
    var buttonStack: some View {
        HStack {
            RoundedButton(text: "Back", image: "chevron.left", size: 12, enabled: (viewModel.depositedThoughtIndex - 1) >= 0, action: {
                print("DepositedThoughtsView --> goToPreviousDepositedThought()")
                withAnimation {
                    viewModel.goToPreviousDepositedThought()
                }
            })
            Spacer()
            RoundedButton(text: "Forget", image: "brain", size: 30, enabled: (viewModel.depositedThoughtIndex) < (viewModel.user?.depositedThoughts.count ?? 0), action: {
                print("DepositedThoughtsView --> popDepositedThought()")
                viewModel.popDepositedThought()
            })
            Spacer()
            RoundedButton(text: "Next", image: "chevron.right", size: 12, enabled: (viewModel.depositedThoughtIndex + 1) < (viewModel.user?.depositedThoughts.count ?? 0), action: {
                print("DepositedThoughtsView --> goToNextDepositedThought()")
                withAnimation {
                    viewModel.goToNextDepositedThought()
                }
            })
        }
    }
    
    func onNext(current: Thought, first: Thought?, last: Thought?) -> Bool  {
        guard let first, first != current else {
            return false
        }
        viewModel.goToNextDepositedThought()
        return true
    }
}

struct DepositedThoughtsView_Previews: PreviewProvider {
    static var previews: some View {
        DepositedThoughtsView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
