//
//  AddThoughtsView.swift
//  ThoughtBank
//
//  Created by Abdulaziz Albahar on 10/19/23.
//

import SwiftUI

struct AddThoughtsView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    
    
    var body: some View {
        Text(viewModel.description)
    }
}

struct AddThoughtsView_Previews: PreviewProvider {
    static var previews: some View {
        AddThoughtsView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
