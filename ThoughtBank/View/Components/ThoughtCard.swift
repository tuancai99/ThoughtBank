//
//  ThoughtCard.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 11/14/23.
//

import SwiftUI

struct ThoughtCard: View {
    var thought: Thought
    let lineSpacing: CGFloat = 24.0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(thought.userID)
                    .font(Font.system(size: lineSpacing))
                    .fontWeight(.bold)
                    .frame(height: lineSpacing * 2)
                    .padding(8)
                Text(thought.content)
                    .font(Font(UIFont(name: "Poppins-Regular", size: lineSpacing) ?? UIFont.systemFont(ofSize: lineSpacing)))
                    .lineSpacing(3)
                    .padding(.leading, 8)
                    .padding(.trailing, 32)
                    .padding(.top, -8)
                Spacer()
            }
            Spacer()
        }
        .ignoresSafeArea()
        .background(NotepadBackground(lineSpacing: lineSpacing, titleHeight: lineSpacing + 12.0))
    }
}

struct NotepadBackground: View {
    @State var cardSize: CGSize = CGSize(width: 0, height: 0)
    @State var lineCount: Int = 0
    
    let lineSpacing: CGFloat
    let titleHeight: CGFloat
    let lineHeight: CGFloat = 1
    
    var body: some View {
        // dynamically determine number of positions
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .onAppear {
                    cardSize = proxy.size
                    lineCount = Int((cardSize.height / lineSpacing) * 0.7) - 1
                }
        }
        .ignoresSafeArea()
        
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.ultraThickMaterial)
            Rectangle()
                .frame(width: 1, height: cardSize.height)
                .foregroundColor(.red)
                .padding(EdgeInsets(top: 0, leading: cardSize.width - 64, bottom: 0, trailing: 0))
            VStack {
                Rectangle()
                    .frame(width: cardSize.width, height: 0)
                    .padding(.bottom, lineSpacing - lineHeight)
                Rectangle()
                    .frame(width: cardSize.width, height: 0)
                    .padding(.bottom, lineSpacing - lineHeight)
                ForEach(0..<lineCount, id: \.self) { pos in
                    Rectangle()
                        .frame(width: cardSize.width, height: lineHeight)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, lineSpacing - lineHeight)
                }
                Spacer()
            }
        }
        
    }
}

struct ThoughtCard_Previews: PreviewProvider {
    static var previews: some View {
        ThoughtCard(thought: Thought(documentID: "a", content: "The quick brown fox jumps over the lazy dog.", userID: "User 1", timestamp: Date()))
            .frame(height: 400)
            .padding(8)
    }
}
