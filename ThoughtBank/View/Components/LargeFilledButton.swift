//
//  LargeFilledButton.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 11/14/23.
//

import SwiftUI

struct LargeFilledButton: View {
    var text: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Spacer()
            Text(text)
                .font(Font.custom("Poppins-Regular", size: 16))
                .fontWeight(.bold)
                .frame(height: 32)
            Spacer()
        })
        .tint(color)
        .buttonStyle(.borderedProminent)
    }
}

struct LargeFilledButton_Previews: PreviewProvider {
    @State var text: String
    static var previews: some View {
        LargeFilledButton(text: "Button", color: .pink, action: {})
    }
}
