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
                viewModel.navigationState = .main
            }
        }
    }
    
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
                        print("Go to previous thought created by user")
                        viewModel.goToNextThought()
                    })
                    Spacer()
                    RoundedButton(text: "Add Thought", image: "plus", size: 30, action: {
                        print("Present modal for AddThoughtView")
                        shouldShowAddThoughtsView = true
                    })
                    .sheet(isPresented: $shouldShowAddThoughtsView) {
                        AddThoughtsView<ViewModel>().environmentObject(viewModel)
                    }
                    Spacer()
                    RoundedButton(text: "Next", image: "chevron.right", size: 12, action: {
                        print("Go to next thought created by user")
                        viewModel.depositThought(thought: viewModel.currentFeedThought)
                        viewModel.goToNextThought()
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
