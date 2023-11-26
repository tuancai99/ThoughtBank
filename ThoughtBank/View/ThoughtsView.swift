//
//  ThoughtsView.swift
//  ThoughtBank
//
//  Created by Abdulaziz Albahar on 11/26/23.
//

import SwiftUI

struct ThoughtsView<ViewModel: ViewModelProtocol>: View {
        
    @Binding var thoughtIndex: Int
    @Binding var thoughts: [Thought]
    
    // Thought (1) given is the one to be popped, (2) is the first in stack, (3) is the last in stack:
    var onNext: (Thought, Thought?, Thought?) -> Bool
    
    var mappedThoughts: [(Int, Thought)] {
        guard thoughtIndex < thoughts.count else {
            return []
        }
        
        return (thoughtIndex..<thoughts.count)
            .map({
                ($0, thoughts[getFlippedIndex(i: $0)])
            })
    }
    
    var stackLimit: Int {
        thoughts.count > 3 ? 3 : thoughts.count - 1
    }
    
    var body: some View {
        ZStack {
            ZStack {
                if !mappedThoughts.isEmpty {
                    
                    // For each loop orders based on the id we specify, thus we can't just user the index for i (the indices change with add/remove):
                    ForEach(mappedThoughts, id: \.1.self) { (i, thought) in
                        
                        ThoughtCard(
                            thought: thought,
                            nextCard: {
                                onNext(thought, mappedThoughts.first?.1, mappedThoughts.last?.1)
                            }
                                
                        )
                        .offset(x: CGFloat(i), y: CGFloat(i))
                        
                        
                    }
                } else {
                    Text("No more cards to show!")
                }
                
            }
            .frame(height: 500)
            
        }
    }
    
    func getFlippedIndex(i: Int) -> Int {
        return (thoughts.count - i - 1) + thoughtIndex
    }
}

#Preview {
    @StateObject var vm = PreviewViewModel()
    
    if let user = vm.user {
        return ThoughtsView<PreviewViewModel>(
            thoughtIndex: $vm.ownedThoughtIndex,
            thoughts: Binding(get: {user.ownedThoughts}, set: {user.ownedThoughts = $0}),
            onNext: {_,_,_ in return true}
        )
    } else {
        return Text("none")
    }
    
    
}
