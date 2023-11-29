//
//  ThoughtCard.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 11/14/23.
//

import SwiftUI

struct ThoughtCard: View {
    var thought: Thought
    let horizontalLineColor: Color
    let verticalLineColor: Color
    let lineSpacing: CGFloat = 24.0
    
    @State var offset: CGSize = .zero
    
    func swipeCard(width: CGFloat) {
        switch width {
        case (150) ... (500):
            if nextCard() {
                offset = CGSize(width: 500, height: 0)
            } else {
                withAnimation {
                    offset = .zero
                }
            }
        default:
            offset = .zero
        }
    }
    
    var nextCard: () -> Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(thought.userID)
                    .font(Font(UIFont(name: "Poppins-Bold", size: lineSpacing) ?? UIFont.systemFont(ofSize: lineSpacing)))
                    .fontWeight(.bold)
                    .frame(height: lineSpacing * 2)
                    .padding(8)
                    .padding(.trailing, 32)
                Text(thought.content)
                    .font(Font(UIFont(name: "Poppins-Regular", size: lineSpacing - 3.3) ?? UIFont.systemFont(ofSize: lineSpacing)))
                    .lineSpacing(3)
                    .padding(.leading, 8)
                    .padding(.trailing, 32)
                    .padding(.top, -8)
                Spacer()
            }
            Spacer()
        }
        .ignoresSafeArea()
        .background(NotepadBackground(isResizable: false, lineSpacing: lineSpacing, topLineMargin: 1, bottomLineMargin: 0, horizontalLineColor: horizontalLineColor, verticalLineColor: verticalLineColor))
        .offset(x: offset.width, y: 0.4 * offset.height)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    withAnimation{
                        swipeCard(width: offset.width)
                    }
                }
        )
        
    }
    
}

struct NotepadBackground: View {
    @State var cardSize: CGSize = CGSize(width: 0, height: 0)
    @State var lineCount: Int = 0
    
    let isResizable: Bool
    let lineSpacing: CGFloat
    let topLineMargin: Int
    let bottomLineMargin: Int
    let lineHeight: CGFloat = 1
    let horizontalLineColor: Color
    let verticalLineColor: Color
    
    var body: some View {
        // dynamically determine number of positions
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .onAppear {
                    cardSize = proxy.size
                    lineCount = Int((cardSize.height / lineSpacing) * 0.7) - topLineMargin - bottomLineMargin
                }
                .onChange(of: proxy.size) { newSize in
                    if isResizable {
                        print(proxy.size)
                        cardSize = proxy.size
                        lineCount = Int((cardSize.height / lineSpacing) * 0.7) - topLineMargin - bottomLineMargin
                    }
                }
        }
        
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.ultraThickMaterial)
            Rectangle()
                .frame(width: 1, height: cardSize.height)
                .foregroundColor(verticalLineColor)
                .padding(EdgeInsets(top: 0, leading: cardSize.width - 64, bottom: 0, trailing: 0))
            VStack {
                ForEach(0...topLineMargin, id: \.self) { pos in
                    Rectangle()
                        .frame(width: cardSize.width, height: 0)
                        .padding(.bottom, lineSpacing - lineHeight)
                }
                ForEach(0..<lineCount, id: \.self) { pos in
                    Rectangle()
                        .frame(width: cardSize.width, height: lineHeight)
                        .foregroundColor(horizontalLineColor)
                        .padding(.bottom, lineSpacing - lineHeight)
                }
                Spacer()
            }
        }
        
    }
}

struct ThoughtCard_Previews: PreviewProvider {
    static var previews: some View {
        ThoughtCard(thought: Thought(documentID: "a", content: "The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.", userID: "abcdefghijklmnopqrstuvwxyz", timestamp: Date()), horizontalLineColor: .blue, verticalLineColor: .red, nextCard: {true})
            .frame(height: 400)
            .padding(16)
    }
}
