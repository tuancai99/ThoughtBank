//
//  AddThoughtsView.swift
//  ThoughtBank
//
//  Created by Abdulaziz Albahar on 10/19/23.
//

import SwiftUI

struct AddThoughtsView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    let maxWidth = UIScreen.main.bounds.width
    let maxLength = UIScreen.main.bounds.height
    let date = Date()
    @ObservedObject var keyboardHeightHelper = KeyboardAdaptive()
    @State var thought : String = ""
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack {
                Text("My Thought")
                    .padding([.leading])
                    .font(.custom("AlegreyaSans", size: 17))
                Spacer()
                Text(Date.now, format: .dateTime.day().month().year())
                    .padding([.trailing], maxLength * 0.06)
                    .font(.system(.subheadline, design: .rounded, weight: .regular))
            }
            .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            
            
            Path() { path in
                path.move(to: CGPoint(x: 0, y: 125))
                path.addLine(to: CGPoint(x: maxWidth, y: 125))
                
                path.move(to: CGPoint(x: 0, y: 175))
                path.addLine(to: CGPoint(x: maxWidth, y: 175))
                
                path.move(to: CGPoint(x: 0, y: 225))
                path.addLine(to: CGPoint(x: maxWidth, y: 225))
                
                path.move(to: CGPoint(x: 0, y: 275))
                path.addLine(to: CGPoint(x: maxWidth, y: 275))
                
                path.move(to: CGPoint(x: 0, y: 325))
                path.addLine(to: CGPoint(x: maxWidth, y: 325))
                
                path.move(to: CGPoint(x: 0, y: 375))
                path.addLine(to: CGPoint(x: maxWidth, y: 375))
                
                path.move(to: CGPoint(x: 0, y: 425))
                path.addLine(to: CGPoint(x: maxWidth, y: 425))
                
                path.move(to: CGPoint(x: 0, y: 475))
                path.addLine(to: CGPoint(x: maxWidth, y: 475))
                
                path.move(to: CGPoint(x: 0, y: 525))
                path.addLine(to: CGPoint(x: maxWidth, y: 525))
                
                path.move(to: CGPoint(x: 0, y: 575))
                path.addLine(to: CGPoint(x: maxWidth, y: 575))
                    
                path.move(to: CGPoint(x: 0, y: 625))
                path.addLine(to: CGPoint(x: maxWidth, y: 625))
                
                path.move(to: CGPoint(x: 0, y: 675))
                path.addLine(to: CGPoint(x: maxWidth, y: 675))
                
                path.move(to: CGPoint(x: 0, y: 725))
                path.addLine(to: CGPoint(x: maxWidth, y: 725))
                
                path.move(to: CGPoint(x: 0, y: 775))
                path.addLine(to: CGPoint(x: maxWidth, y: 775))

            }
            .stroke(lineWidth: 2.0)
            .zIndex(0)
            
            Path() { path in
                path.move(to: CGPoint(x: 350, y: 0))
                path.addLine(to: CGPoint(x: 350, y: maxLength))
            }
            .stroke(Color.red, lineWidth: 2.0)
            .zIndex(1.0)
            
            TextField("Enter a thought...", text: $thought, axis: .vertical)
                .offset(x: 10, y: 95)
                .font(.system(size: 25, weight: .regular, design: .serif))
                .frame(width: 340)
                .lineSpacing(20)
                .zIndex(2.0)
    
            Button(action: nothing) {
                Text("Draft")
                    .bold()
            }
            .padding()
            .frame(width: 107, height: 30)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 0.97, green: 0.97, blue: 0.97)))
            .foregroundColor(Color.blue)
            .offset(CGSize(width: 85, height: 740))
            .offset(y: -self.keyboardHeightHelper.keyboardHeight)
            .zIndex(3.0)
            
            Button(action: nothing) {
                Text("Post").bold()
                    
            }
            .padding()
            .frame(width: 107, height: 30)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
            .foregroundColor(Color.white)
            .offset(CGSize(width: 210, height: 740))
            .offset(y: -self.keyboardHeightHelper.keyboardHeight)
            .zIndex(3.0)
        }
        
    }
}
func nothing() {
    
}

struct AddThoughtsView_Previews: PreviewProvider {
    static var previews: some View {
        AddThoughtsView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}

