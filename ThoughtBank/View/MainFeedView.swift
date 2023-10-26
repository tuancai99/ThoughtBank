//
//  FeedView.swift
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

struct MainFeedView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            ZStack {
                /*Rectangle()
                    .frame(width: 321, height: 444)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 4, x:0, y:4)
                    .offset(x: -21, y:-24)*/
                Rectangle()
                    .frame(width: 321, height: 444)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 4, x:0, y:4)
                    .offset(x: -9, y:-16)
                Rectangle()
                    .frame(width: 321, height: 444)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 4, x:0, y:4)
                    .offset(x: 3, y:-8)
                ZStack {
                    Rectangle()
                        .frame(width: 321, height: 444)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 4, x:0, y:4)
                        .offset(x:15)
                    VStack (spacing:39) {
                        Rectangle()
                            .frame(width: 321, height: 0.4)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Rectangle()
                            .frame(width: 321, height: 0.4)
                            .foregroundColor(.blue)
                        Rectangle()
                            .frame(width: 321, height: 0.4)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Rectangle()
                            .frame(width: 321, height: 0.4)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Rectangle()
                            .frame(width: 321, height: 0.4)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Rectangle()
                            .frame(width: 321, height: 0.4)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Rectangle()
                            .frame(width: 321, height: 0.4)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Rectangle()
                            .frame(width: 321, height: 0.4)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Rectangle()
                            .frame(width: 321, height: 0.4)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Rectangle()
                            .frame(width: 321, height: 0.4)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        
                    }
                    .offset(x:15, y:-3)
                    Rectangle()
                        .frame(width:1, height: 444)
                        .foregroundColor(.red)
                        .offset(x:130)
                }
                
            }
            .offset(x:-8,y:-40)
            HStack (spacing: 40) {
                VStack {
                    Button {
                        print("Bye")
                    } label: {
                        Circle()
                            .frame(width: 35, height: 35)
                            .shadow(color: .gray, radius: 3, x: 0, y: 2)
                            .foregroundColor(.white)
                            .overlay(Image(systemName: "chevron.left")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 8, height:12.43))
                    }
                    Text("Reject")
                        .offset(y:14)
                }
                VStack {
                    Button {
                        print("New")
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 53, height: 53)
                                .shadow(color: .gray, radius: 3, x: 0, y: 2)
                                .foregroundColor(.white)
                            Image(systemName: "plus")
                                .resizable()
                                .foregroundColor(.black)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30, height: 30)
                            
                        }
                    }
                    Text("Add Thought")
                        .offset(y:5)
                }
                VStack {
                    Button {
                        print("Hi")
                    } label: {
                        Circle()
                            .frame(width: 35, height: 35)
                            .shadow(color: .gray, radius: 3, x: 0, y: 2)
                            .foregroundColor(.white)
                            .overlay(Image(systemName: "chevron.right")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 8, height:12.43))
                        
                    }
                    Text("Deposit")
                        .offset(y:14)
                    
                }
            }
            .offset(y:0)
        }
    }
}

struct MainFeedView_Previews: PreviewProvider {
    static var previews: some View {
        MainFeedView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
