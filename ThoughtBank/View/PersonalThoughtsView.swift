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
    
    @State var shouldWarnApproachingLimit: Bool = false
    @State var shouldNotifyOutOfThoughts: Bool = false
    
    var body: some View {
        VStack {
            if let user = viewModel.user {
                ThoughtsView<ViewModel>(
                    thoughtIndex: $viewModel.ownedThoughtIndex,
                    thoughts: Binding(get: {user.ownedThoughts}, set: {user.ownedThoughts = $0}),
                    refreshAction: nil,
                    horizontalLineColor: .blue,
                    verticalLineColor: .green,
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
                    print("PersonalThoughtsView --> setScreen(.login)")
                    viewModel.setScreen(to: .login)
                })
                .padding()
                Spacer()
            }
        }
    }
    
    var buttonStack: some View {
        HStack {
            RoundedButton(text: "Back", image: "chevron.left", size: 12,
                          enabled: (viewModel.ownedThoughtIndex - 1) >= 0, action: {
                print("PersonalThoughtsView --> goToPreviousOwnedThought()")
                withAnimation {
                    viewModel.goToPreviousOwnedThought()
                }
            })
            
            Spacer()
            
            RoundedButton(text: "Add Thought", image: "plus", size: 30, action: {
                if viewModel.remainingThoughtsCount <= 0 {
                    print("PersonalThoughtsView --> ENABLE shouldNotifyOutOfThoughts")
                    shouldNotifyOutOfThoughts = true
                } else if viewModel.remainingThoughtsCount == 1 {
                    print("PersonalThoughtsView --> ENABLE shouldWarnApproachingLimit")
                    shouldWarnApproachingLimit = true
                } else {
                    print("PersonalThoughtsView --> ENABLE shouldShowAddThoughtsView")
                    viewModel.shouldShowAddThoughtsView = true
                }
            })
            .sheet(isPresented: $viewModel.shouldShowAddThoughtsView) {
                AddThoughtsView<ViewModel>().environmentObject(viewModel)
            }
            .alert("Out of thoughts", isPresented: $shouldNotifyOutOfThoughts, actions: {
                Button(action: {
                }, label: {
                    Text("OK")
                })
            }, message: {
                Text("You've reached the daily limit! You can share more thoughts tomorrow.")
            })
            .alert("Last daily thought", isPresented: $shouldWarnApproachingLimit, actions: {
                Button(action: {
                    print("PersonalThoughtsView --> ENABLE shouldShowAddThoughtsView")
                    viewModel.shouldShowAddThoughtsView = true
                }, label: {
                    Text("OK")
                })
            }, message: {
                Text("You can share one more thought today. Make it count!")
            })
            
            
            Spacer()
            
            RoundedButton(text: "Next", image: "chevron.right", size: 12, enabled: (viewModel.ownedThoughtIndex + 1) < (viewModel.user?.ownedThoughts.count ?? 0), action: {
                print("PersonalThoughtsView --> goToNextOwnedThought()")
                withAnimation {
                    viewModel.goToNextOwnedThought()
                }
            })
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
