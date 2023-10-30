//
//  PersonalThoughtsView.swift
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

struct PersonalThoughtsView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 4)
                    .frame(width: 321, height: 444)
                Rectangle()
                    .foregroundColor(.clear)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 4)
                    .frame(width: 321, height: 444)
                    .offset(CGSize(width: 12, height: 12))
                Rectangle()
                    .foregroundColor(.clear)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 4)
                    .frame(width: 321, height: 444)
                    .offset(CGSize(width: 24, height: 24))
                Rectangle()
                    .foregroundColor(.clear)
                    .background(.white)
                    .frame(width: 321, height: 444)
                    .offset(CGSize(width: 36, height: 36))
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                VStack (spacing: 39) {
                    Rectangle()
                        .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                        .frame(width:321, height:1)
                    Rectangle()
                        .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                        .frame(width:321, height:1)
                    Rectangle()
                        .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                        .frame(width:321, height:1)
                    Rectangle()
                        .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                        .frame(width:321, height:1)
                    Rectangle()
                        .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                        .frame(width:321, height:1)
                    Rectangle()
                        .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                        .frame(width:321, height:1)
                    Rectangle()
                        .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                        .frame(width:321, height:1)
                    Rectangle()
                        .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                        .frame(width:321, height:1)
                    Rectangle()
                        .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                        .frame(width:321, height:1)
                    Rectangle()
                        .stroke(Color(red: 0.06, green: 0.16, blue: 0.41).opacity(0.54), lineWidth: 1)
                        .frame(width:321, height:1)
                }.offset(x:35, y:38)
                
                Text("My Biggest Fear")
                    .font(
                        Font.custom("Arial", size: 25)
                            .weight(.bold)
                    )
                    .kerning(0.092)
                    .foregroundColor(Color(red: 0.36, green: 0.36, blue: 0.36))
                    .frame(width: 236, height: 48, alignment: .topLeading)
                    .offset(x:3, y:-150)


                Text("Imagine a world where time flows backward, and people age in reverse. They start as wise elders and gradually become youthful children.")
                    .font(Font.custom("Arial", size: 25))
                    .kerning(0.092)
                    .foregroundColor(Color(red: 0.36, green: 0.36, blue: 0.36))
                    .frame(width: 273, height: 324, alignment: .topLeading)
                    .lineSpacing(12)
                    .offset(x:20, y:31)
                Text("10/13/2023")
                    .font(
                        Font.custom("Times", size: 17)
                        .italic()
                    )
                    .kerning(1.592)
                    .foregroundColor(Color(red: 0.36, green: 0.36, blue: 0.36))

                    .frame(width: 142, alignment: .topLeading)
                    .offset(x:-45, y:240)
                
                Rectangle()
                    .stroke(Color(red: 0.51, green: 0, blue: 0).opacity(0.24), lineWidth: 3)
                    .frame(width: 444.01016, height: 1)
                    .rotationEffect(Angle(degrees: -90))
                    .offset(x:150, y:37)

            } .frame(width: 390, height: 844)
                .offset(x:-22, y:-70)
            
            HStack {
                Button {
                    print(" ")
                } label: {
                    VStack {
                        ZStack {
                            Circle()
                                .frame(width: 35, height: 35)
                                .background(.black.opacity(0))
                                .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 2)
                                .foregroundColor(.white)
                            Image(systemName: "chevron.left")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width:8, height: 12.43229)
                        }
                        Text("Back")
                            .font(
                            Font.custom("Arial", size: 12)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)

                            .frame(width: 77, alignment: .top)
                    }
                } .frame(width:100, height:100)
                
                
                Button {
                    print(" ")
                } label: {
                    VStack {
                        ZStack {
                            Circle()
                                .frame(width: 53, height: 53)
                                .background(.black.opacity(0))
                                .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 2)
                                .foregroundColor(.white)
                            Image(systemName: "plus")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width:30, height: 30)
                        }
                        Text("Add Thought")
                            .font(
                            Font.custom("Arial", size: 12)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)

                            .frame(width: 77, alignment: .top)
                    }
                }
                    .frame(width:100, height:100)
                    .padding([.leading, .trailing], 45)
                
                Button {
                    print(" ")
                } label: {
                    VStack {
                        ZStack {
                            Circle()
                                .frame(width: 35, height: 35)
                                .background(.black.opacity(0))
                                .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 2)
                                .foregroundColor(.white)
                            Image(systemName: "chevron.right")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width:8, height: 12.43229)
                        }
                        Text("View More")
                            .font(
                            Font.custom("Arial", size: 12)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)

                            .frame(width: 77, alignment: .top)
                    }
                }.frame(width:100, height:100)
            }.offset(y:-170)
            
        }

    }
}

struct PersonalThoughtsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalThoughtsView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
