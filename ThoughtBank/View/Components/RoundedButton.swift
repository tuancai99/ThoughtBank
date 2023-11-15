//
//  RoundedButton.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 11/15/23.
//

import SwiftUI

struct RoundedButton: View {
    var text: String
    var image: String
    var size: CGFloat
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action, label: {
                ZStack {
                    Circle()
                        .frame(width: size + 28, height: size + 28)
                        .shadow(color: .gray, radius: 3, x: 0, y: 2)
                        .foregroundColor(.white)
                    Image(systemName: image)
                        .resizable()
                        .foregroundColor(.black)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size, height: size)
                }
            })
            Text(text)
                .offset(y:5)
        }
    }
}

#Preview {
    RoundedButton(text: "Hello", image: "chevron.left", size: 8, action: {})
}
