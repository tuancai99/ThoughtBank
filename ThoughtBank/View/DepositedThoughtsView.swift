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
        
        ZStack {
            if let user = viewModel.user {
                ThoughtsView<ViewModel>(
                    thoughtIndex: $viewModel.depositedThoughtIndex,
                    thoughts: Binding(get: {user.depositedThoughts}, set: {user.depositedThoughts = $0}),
                    onNext: onNext
                )
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 144, trailing: 32))
                
            } else {
                Text("User data is unavailable.")
            }
                        
            VStack {
                Spacer()
                HStack {
                    RoundedButton(text: "Back", image: "chevron.left", size: 12, action: {
                        // TODO: Implement "Back" button for deposited thoughts
                        viewModel.goToPreviousDepositedThought()
                    })
                    Spacer()
                    RoundedButton(text: "Forget", image: "brain", size: 30, action: {
                        print("Delete this thought from deposited thoughts.")
                        // Pop deposited thought
                        viewModel.popDepositedThought()
                    })
                    Spacer()
                    RoundedButton(text: "Next", image: "chevron.right", size: 12, action: {
                        // TODO: Implement "Next" button for deposited thoughts
                        viewModel.goToNextDepositedThought()
                    })
                }
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 48, trailing: 32))
            }
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
        DepositedThoughtsView<CentralViewModel>().environmentObject(CentralViewModel())
    }
}
