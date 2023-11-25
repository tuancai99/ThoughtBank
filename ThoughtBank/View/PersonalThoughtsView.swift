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
    
    @State var shouldShowAddThoughtsView: Bool = false {
        didSet {
            if shouldShowAddThoughtsView {
                viewModel.navigationState = .add
            } else {
                viewModel.navigationState = .ownedThoughts
            }
        }
    }
    
    var body: some View {
        ZStack {
            ZStack {
                if let user = viewModel.user {
                    let thoughts: [Thought] = user.ownedThoughts
                    if viewModel.ownedThoughtIndex < thoughts.count {
                        ForEach(viewModel.ownedThoughtIndex..<thoughts.count,id: \.self) { i in
                            
                            let flippedIndex: Int = (thoughts.count - i - 1) + viewModel.ownedThoughtIndex
                            
                            ThoughtCard(thought: thoughts[flippedIndex], nextCard: viewModel.goToNextOwnedThought)
                                .offset(x: CGFloat(i), y: CGFloat(i))
                        }
                    } else {
                        Text("No more cards to show!")
                    }
                } else {
                    Text("User data is unavailable.")
                }
            }
            .padding(EdgeInsets(top: 64, leading: 32, bottom: 144, trailing: 32))
            
            VStack {
                Spacer()
                HStack {
                    RoundedButton(text: "Back", image: "chevron.left", size: 12, action: {
                        // TODO: Implement "Back" button for owned thoughts
                        print("Go to previous thought created by user")
                    })
                    
                    Spacer()
                    
                    RoundedButton(text: "Add Thought", image: "plus", size: 30, action: {
                        shouldShowAddThoughtsView = true
                    })
                    .sheet(isPresented: $shouldShowAddThoughtsView) {
                        AddThoughtsView<ViewModel>().environmentObject(viewModel)
                    }
                    
                    Spacer()
                    
                    RoundedButton(text: "Next", image: "chevron.right", size: 12, action: {
                        // TODO: Implement "Next" button for owned thoughts
                        print("Go to next thought created by user")
                    })
                }
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 48, trailing: 32))
            }
        }
    }
}

struct PersonalThoughtsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalThoughtsView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
