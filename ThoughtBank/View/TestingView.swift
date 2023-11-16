//
//  TestingView.swift
//  ThoughtBank
//
//  Created by Abdulaziz Albahar on 11/2/23.
//

import SwiftUI

struct TestingView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var vm: ViewModel
    
    @State var fetched: [Thought] = []
    @State var alias: String = " "
    
    var body: some View {
        VStack {
            Button(action: {
                fetch()
               
            }, label: {Text("click to fetch")})
            
            ForEach(fetched, id: \.id) { item in
                Text(item.content)
            }
            
            Text("Alias: \(self.alias)")
            
        }
    }
    
    func fetch() {
        Task {
            do {
                let user =  try await FirebaseManager.manager.fetchUser()
                fetched = user.ownedThoughts
                self.alias = user.alias
            } catch {
                fetched = []
            }
        }
    }
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
