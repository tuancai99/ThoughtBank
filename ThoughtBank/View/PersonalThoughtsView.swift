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
    
    var mappedOwnedThoughts: [(Int, Thought)] {
        let thoughts = viewModel.ownedThoughts
        guard viewModel.ownedThoughtIndex < thoughts.count else {
            return []
        }
        
        return (viewModel.ownedThoughtIndex..<thoughts.count)
            .map({
                ($0, thoughts[getFlippedIndex(i: $0)])
            })
    }
    
    var body: some View {
        ZStack {
            ZStack {
                if viewModel.user != nil {
                    if !mappedOwnedThoughts.isEmpty {
                        
                        // For each loop orders based on the id we specify, thus we can't just user the index for i (the indices change with add/remove):
                        ForEach(mappedOwnedThoughts ,id: \.1.self) { (i, thought) in
                            
                            ThoughtCard(
                                thought: thought,
                                nextCard: viewModel.goToNextOwnedThought
                            )
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
                        print("Go to previous thought created by user.")
                        viewModel.goToPreviousOwnedThought()
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
    
    func getFlippedIndex(i: Int) -> Int {
        return (viewModel.ownedThoughts.count - i - 1) + viewModel.ownedThoughtIndex
    }
}

struct PersonalThoughtsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalThoughtsView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
