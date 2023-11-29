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
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action, label: {
                ZStack {
                    Circle()
                        .frame(width: size + 24, height: size + 24)
                        .shadow(color: .gray, radius: colorScheme == .light ? 3 : 0, x: 0, y: 0)
                        .foregroundColor(colorScheme == .light ? .white : .pink)
                    Image(systemName: image)
                        .resizable()
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size, height: size)
                }
            })
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
