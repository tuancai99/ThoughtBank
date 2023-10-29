//
//  LoginView.swift
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

struct LoginView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack (){
            Spacer()
            Image("go-back").frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
            
            Image("_854593dc-cfb1-4f81-affa-a328401049e9 1")
            
            ZStack() {
                Text("Welcome").font(Font.custom("SmoochSans-SemiBold", size: 80)).foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.11)).offset(x: 0, y: -15.50)
                
                Text("Hello again, login to view thoughts").font(Font.custom("Poppins", size: 14)).foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.11)).offset(x: -2, y: 30)
            }
            .frame(width: 347, height: 105)
            
            ZStack() {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 364, height: 52)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .cornerRadius(13)
                HStack {
                    Image("Vector").padding()
                    TextField("Email", text: $email).font(Font.custom("Poppins", size: 12)).padding()
                }.padding(.horizontal, 13)
                
            }.padding(.horizontal, 0).padding(.bottom, 10)
            
            ZStack() {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 364, height: 52)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .cornerRadius(13)
                
                HStack {
                    Image("Frame").padding()
                    TextField("Password", text: $password).font(Font.custom("Poppins", size: 12)).padding(.horizontal, 10)
                }
                .padding(.horizontal, 10)
            }.padding(.horizontal, 0).padding(.bottom, 10)
            
            
            Button(action: {
                // Handle the login action here
                print("Logging in with email: \(email), password: \(password)")
            }) {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.11))
                        .frame(width: 364, height: 52)
                        .cornerRadius(13)
                    
                    Text("Login")
                        .font(Font.custom("Poppins", size: 12)
                        .weight(.bold))
                        .foregroundColor(.white)
                }
            }.frame(width: 364, height: 52)
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
            Text("Forgot Password?")
                .font(Font.custom("Poppins", size: 14))
                .foregroundColor(Color(red: 0, green: 0.10, blue: 1))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
            Spacer()
            
        }.frame(width: 390, height: 844).background(.white)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}

