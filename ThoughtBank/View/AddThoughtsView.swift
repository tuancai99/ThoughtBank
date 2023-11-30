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
    var fontSize: CGFloat = 25
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Text("My Thought")
                        .padding(.leading, 16)
                        .font(.custom("AlegreyaSans", size: 17))
                    Spacer()
                    Text(Date.now, format: .dateTime.day().month().year())
                        .padding([.trailing], maxLength * 0.06)
                        .font(.system(.subheadline, design: .rounded, weight: .regular))
                }
                .padding(.top, 20)
                
                TextField("Enter a thought...", text: $thought,axis: .vertical)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 32))
                    .font(.system(size: fontSize, weight: .regular, design: .serif))
                    .lineSpacing(3)
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        // TODO: Implement "Draft" button
                        // - We need to call the viewModel to store a thought locally
                        print("AddThoughtsView --> (not implemented)")
                    }) {
                        Text("Draft")
                            .bold()
                            .frame(width: 92, height: 30)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.gray)
                    
                    Spacer()
                    
                    Button(action: {
                        if (viewModel.remainingThoughtsCount > 0) {
                            viewModel.remainingThoughtsCount -= 1
                            print("AddThoughtsView --> createThought(...)")
                            viewModel.createThought(text: thought)
                        } else {
                            print("AddThoughtsView --> Out of thoughts!")
                        }
                    }) {
                        Text("Post")
                            .bold()
                            .frame(width: 92, height: 30)
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
                .padding(.bottom, 32)
            }
            // Buggy with keyboard -- supposed to display background as notepad style
            //.background(NotepadBackground(isResizable: true, lineSpacing: fontSize, topLineMargin: 2, bottomLineMargin: 2))
            
            
            ProgressOverlay(isVisible: $viewModel.shouldLoadBlocking)

        }
    }
}

struct AddThoughtsView_Previews: PreviewProvider {
    static var previews: some View {
        AddThoughtsView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}

