//
//  LandingPageView.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Contributors:
//  [Soham Shetty]
//
//  View for landing page.
//
//  --- NOTE ---
//  This view should only deal with UI logic.
//  Actual data logic should be handled in CentralViewModel.
//

import SwiftUI

struct LandingPageView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
  

    
    var body: some View {
        
        VStack(spacing: 90){
            Image("Logo")
               // Spacer()
                
            VStack(spacing: -45){
                Text("See what the \n world is thinking")
                    .font(
                        Font.custom("SmoochSans-ExtraBold", size: 70)
                        //.weight(.bold)
                    )
                    .kerning(0.35)
                    .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.11))
                
                
                Button(action:{}, label: {
                    Text("Create account")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .padding(100)
                        .background(Color.black
                            .cornerRadius(13)
                            .frame(width: 375,height: 50)
                        )
                    
                    
                })
            }
            
            Spacer()
            
                HStack(){
                    Text("Already have an account?")
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Sign in")
                        
                    })
                }
                
            
            
            
            
            
        }
    }
    
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
