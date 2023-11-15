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
            ZStack {
                if let user = viewModel.user {
                    let thoughts: [Thought] = user.depositedThoughts
                    if viewModel.depositedThoughtIndex < thoughts.count {
                        ForEach(viewModel.depositedThoughtIndex..<thoughts.count,id: \.self) { i in
                            let flippedIndex: Int = (thoughts.count - i - 1) + viewModel.depositedThoughtIndex
                            ThoughtCard(thought: thoughts[flippedIndex])
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
                        // TODO: Implement "Back" button for deposited thoughts
                        print("Go to previous thought deposited by user")
                    })
                    Spacer()
                    RoundedButton(text: "Forget", image: "brain", size: 30, action: {
                        print("Delete this thought from deposited thoughts")
                        // Pop deposited thought
                    })
                    Spacer()
                    RoundedButton(text: "Next", image: "chevron.right", size: 12, action: {
                        // TODO: Implement "Next" button for deposited thoughts
                        print("Go to next thought deposited by user")
                    })
                }
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 48, trailing: 32))
            }
        }
    }
}

struct DepositedThoughtsView_Previews: PreviewProvider {
    static var previews: some View {
        DepositedThoughtsView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
