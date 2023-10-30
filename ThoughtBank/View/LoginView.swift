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

            Image("go-back")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                .padding(.top, 10)
            
            Image("_854593dc-cfb1-4f81-affa-a328401049e9 1").padding(.bottom,-20)
            
            VStack(spacing: 0) {
                Text("Welcome").font(Font.custom("SmoochSans-SemiBold", size: 80))
                    .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.11))
                Text("Hello again, login to view thoughts")
                    .font(Font.custom("Poppins", size: 14))
                    .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.11))
                    .padding(.top, -10)
            }.padding(.vertical, 10)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 52)
                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                .cornerRadius(13)
                .padding(.horizontal, 10)
            .overlay(
                HStack {
                    Image("Vector")
                        .foregroundColor(.secondary)
                        .padding(.leading, 24)
                    TextField("Email", text: $email)
                        .padding(.leading, 30)
                        .font(Font.custom("Poppins", size: 12))
                        .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.11))
                }
                .padding()
            ).padding(.vertical, 3)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 52)
                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                .cornerRadius(13)
                .padding(.horizontal, 10)
            .overlay(
                HStack {
                    Image("Frame")
                        .padding(.leading, 20)
                        .foregroundColor(.secondary)
                    TextField("Password", text: $password)
                        .padding(.leading, 26)
                        .font(Font.custom("Poppins", size: 12))
                        .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.11))
                }
                .padding()
            ).padding(.vertical, 3)
            
            
            
            Button(action: {
                // Handle the login action here
                print("Logging in with email: \(email), password: \(password)")
            }) {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 1, green: 0.64, blue: 0.88).opacity(0.60))
                        .frame(height: 52)
                        .cornerRadius(13)
                        .padding(.horizontal, 10)
                    
                    Text("Join")
                        .font(Font.custom("Poppins", size: 12)
                        .weight(.bold))
                        .foregroundColor(.black)
                }
            }.padding(.vertical, 3)
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            HStack {
                Text("Already have an account?")
                    .font(Font.custom("Poppins", size: 14))
                Text("Sign in")
                    .font(Font.custom("Poppins", size: 14))
                    .foregroundColor(Color(red: 0, green: 0.10, blue: 1))
            }.padding(.bottom, -10)
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}

