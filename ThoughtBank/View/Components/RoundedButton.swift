//
//  RoundedButton.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 11/15/23.
//

import SwiftUI

struct RoundedButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    var text: String
    var image: String
    var size: CGFloat
    var enabled: Bool = true
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action, label: {
                ZStack {
                    Circle()
                        .frame(width: size + 24, height: size + 24)
                        .shadow(color: .gray, radius: !enabled ? 0 : (colorScheme == .light ? 1.5 : 0), x: 0, y: 0)
                        .foregroundColor(!enabled ? .gray : (colorScheme == .light ? .white : .pink))
                    Image(systemName: image)
                        .resizable()
                        .foregroundColor(!enabled ? .white : (colorScheme == .light ? .black : .white))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size, height: size)
                }
            })
            .disabled(!enabled)
            Text(text)
                .offset(y:5)
        }
        .frame(width: (size + 24) * 2, height: (size + 24) * 2)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(text: "Deposit", image: "chevron.left", size: 8, action: {})
    }
}
