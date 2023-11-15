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
                ForEach(0..<viewModel.feedThoughts.count, id: \.self) { i in
                    ThoughtCard(thought: viewModel.feedThoughts[viewModel.feedThoughts.count - i - 1])
                        .offset(x: CGFloat(i), y: CGFloat(i))
                }
            }
            .padding(EdgeInsets(top: 64, leading: 32, bottom: 144, trailing: 32))
            VStack {
                Spacer()
                HStack {
                    RoundedButton(text: "Back", image: "chevron.left", size: 12, action: {
                        print("Go to previous thought deposited by user")
                        viewModel.goToNextThought()
                    })
                    Spacer()
                    RoundedButton(text: "Forget", image: "brain", size: 30, action: {
                        print("Delete this thought from deposited thoughts")
                        // Pop deposited thought
                    })
                    Spacer()
                    RoundedButton(text: "Next", image: "chevron.right", size: 12, action: {
                        print("Go to next thought deposited by user")
                        viewModel.depositThought(thought: viewModel.currentFeedThought)
                        viewModel.goToNextThought()
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
