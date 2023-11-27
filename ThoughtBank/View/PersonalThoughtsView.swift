//
//  PersonalThoughtsView.swift
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

struct PersonalThoughtsView<ViewModel: ViewModelProtocol>: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            if let user = viewModel.user {
                ThoughtsView<ViewModel>(
                    thoughtIndex: $viewModel.ownedThoughtIndex,
                    thoughts: Binding(get: {user.ownedThoughts}, set: {user.ownedThoughts = $0}),
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
                        // TODO: Implement "Back" button for owned thoughts
                        withAnimation {
                            viewModel.goToPreviousOwnedThought()
                        }
                        print("Go to previous thought created by user.")
                    })
                    
                    Spacer()
                    
                    RoundedButton(text: "Add Thought", image: "plus", size: 30, action: {
                        viewModel.shouldShowAddThoughtsView = true
                    })
                    .sheet(isPresented: $viewModel.shouldShowAddThoughtsView) {
                        AddThoughtsView<ViewModel>().environmentObject(viewModel)
                    }
                    
                    Spacer()
                    
                    RoundedButton(text: "Next", image: "chevron.right", size: 12, action: {
                        // TODO: Implement "Next" button for owned thoughts
                        print("Go to next thought created by user")
                        viewModel.goToNextOwnedThought()
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
        viewModel.goToNextOwnedThought()
        return true
    }
}

struct PersonalThoughtsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalThoughtsView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
