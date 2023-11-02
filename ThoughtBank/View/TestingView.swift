//
//  TestingView.swift
//  ThoughtBank
//
//  Created by Abdulaziz Albahar on 11/2/23.
//

import SwiftUI

struct TestingView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
