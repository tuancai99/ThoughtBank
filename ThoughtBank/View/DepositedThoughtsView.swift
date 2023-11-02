//
//  DepositedThoughtsView.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Contributors:
//  [YOUR NAME HERE]
//
//  --- NOTE ---
//  This view should only deal with UI logic.
//  Actual data logic should be handled in CentralViewModel.
//

import SwiftUI

struct DepositedThoughtsView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    
    let height = UIScreen.main.bounds.size.height
    let width = UIScreen.main.bounds.size.width
    
    @State var thoughtIndex = 0
    //    @State var thoughts = user.depositedThoughts
    @State var thoughts: [Thought] = [
        Thought(documentID: "1", content: "Hello, This is an example thought. Thus proving that this app works!", userID: "Laksh", timestamp: Date()),
        Thought(documentID: "2", content: "This is another thought that shows how the app works.", userID: "Laksh", timestamp: Date()),
        Thought(documentID: "3", content: "The app works very well as you can see by this other exam", userID: "Laksh", timestamp: Date())
    ]
    
    var body: some View {
//        Text("Hello")
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: width - 80, height: 2*height/5)
                  .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                  .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                  .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: -1)
                  .offset(x: -10, y: -10)
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: width - 80, height: 2*height/5)
                  .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                  .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                  .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: -1)
                ZStack {
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: width - 80, height: 2*height/5)
                      .background(.white)
                      .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                      .overlay(
                        ZStack {
//                            Text("This is a very long example text to see what the text element looks like")
                            VStack(alignment: .leading) {
                                Text("Heading")
                                    .bold()
                                    .font(.custom("Times New Roman", size: 28))
                                Text(thoughts[thoughtIndex].content)
                                    .lineSpacing(11)
                                    .padding(.top, 0.001)
                                Spacer()
                                Text("User")
                                    .italic()
                                
                            }
                            .padding(.trailing, 40)
                            .padding(.vertical, 20)
                            .offset(y: -5)
                            
                            VStack(spacing: 30) {
                              Image("Line")
                                  .frame(width: width-80, height: 1)
                                  .overlay(
                                  Rectangle()
                                      .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                              )
                              Image("Line")
                                  .frame(width: width-80, height: 1)
                                  .overlay(
                                  Rectangle()
                                      .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                              )
                              Image("Line")
                                  .frame(width: width-80, height: 1)
                                  .overlay(
                                  Rectangle()
                                      .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                              )
                              Image("Line")
                                  .frame(width: width-80, height: 1)
                                  .overlay(
                                  Rectangle()
                                      .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                              )
                              Image("Line")
                                  .frame(width: width-80, height: 1)
                                  .overlay(
                                  Rectangle()
                                      .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                              )
                              Image("Line")
                                  .frame(width: width-80, height: 1)
                                  .overlay(
                                  Rectangle()
                                      .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                              )
                              Image("Line")
                                  .frame(width: width-80, height: 1)
                                  .overlay(
                                  Rectangle()
                                      .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                              )
                              Image("Line")
                                  .frame(width: width-80, height: 1)
                                  .overlay(
                                  Rectangle()
                                      .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                              )
                              Image("Line")
                                  .frame(width: width-80, height: 1)
                                  .overlay(
                                  Rectangle()
                                      .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                              )
                          }
                    })
                    Image("Line")
                        .frame(width: 2*height/5, height: 1)
                        .overlay(
                            Rectangle()
                            .stroke(Color(red: 0.51, green: 0, blue: 0).opacity(0.24), lineWidth: 3)
                        )
                        .offset(x: 0, y: 120)
                        .rotationEffect(Angle(degrees: -90))
                }
                .offset(x: 10, y: 10)
            }
            Spacer()
            HStack(spacing: 30) {
                VStack {
                    Button(action: {
                        print("Previous")
                        if(thoughtIndex == 0) {thoughtIndex = thoughts.count - 1}
                        else {thoughtIndex -= 1}
                        
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 32, height: 32)
                                .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 2)
                            Image(systemName: "chevron.left")
                                .cornerRadius(10)
                                .font(.system(size: 17))
                                .foregroundColor(.black)
                        }
                    }
                    Text("Previous")
                        .font(.custom("Arial", size: 12))
                        .foregroundColor(.gray)
                }
                VStack {
                    Button(action: {
                        print("Add Thought")
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 45, height: 45)
                                .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 2)
                            Image(systemName: "plus")
                                .cornerRadius(10)
                                .font(.system(size: 30))
                                .foregroundColor(.black)
                        }
                    }
                    Text("Add Thought")
                        .font(.custom("Arial", size: 12))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                VStack {
                    Button(action: {
                        print("Next")
                        if(thoughtIndex == thoughts.count-1) {thoughtIndex = 0;}
                        else {thoughtIndex += 1}
                        
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 32, height: 32)
                                .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 2)
                            Image(systemName: "chevron.right")
                                .cornerRadius(10)
                                .font(.system(size: 17))
                                .foregroundColor(.black)
                        }
                    }
                    Text("Next")
                        .font(.custom("Arial", size: 12))
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct DepositedThoughtsView_Previews: PreviewProvider {
    static var previews: some View {
        DepositedThoughtsView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
