//
//  SettingsView.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 10/17/23.
//
//  Contributors:
//  Janah Abu Hassan
//
//  --- NOTE ---
//  This view should only deal with UI logic.
//  Actual data logic should be handled in CentralViewModel.
//

import SwiftUI

struct SettingsView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var isToggleOn = true
    @State private var isShowingDeleteConfirmation = false
    @State private var isAccountDeleted = false
    @State private var isProfilePresented = false
    @State private var isAboutUsPresented = false
    @State private var isPrivacyPolicyPresented = false
    @State private var isTermsAndConditionsPresented = false
    @State var presentAlert = false
    @State var isActive: Bool = false
    @State var isCustomDialog = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack() {
                        Text("Your Alias:")
                            .bold()
                        Text(viewModel.user?.alias ?? "N/A")
                        Spacer()
                    }.padding(.bottom, 8)
                    
                    HStack {
                        Text("Thoughts Remaining Today:")
                            .bold()
                        Text(String(viewModel.remainingThoughtsCount))
                        Spacer()
                    }
                    
                    Divider()
                    
                    VStack {
                        /*
                         // Need to implement ability to view profiles
                         SettingsListItem(text: "View profile", clickAction: {
                         isProfilePresented.toggle()
                         })
                         .sheet(isPresented: $isProfilePresented) {
                         ProfileView(isSheetPresented: $isProfilePresented)
                         }
                         */
                        
                        HStack {
                            Toggle(isOn: $isToggleOn, label: {
                                Text("Push notifications")
                            })
                        }
                    }
                    
                    Divider()
                    
                    VStack {
                        SettingsListItem(text: "About us", clickAction: {
                            isAboutUsPresented.toggle()
                        })
                        .sheet(isPresented: $isAboutUsPresented) {
                            AboutView(isSheetPresented: $isAboutUsPresented)
                        }
                        
                        SettingsListItem(text: "Privacy policy", clickAction: {
                            isPrivacyPolicyPresented.toggle()
                        })
                        .sheet(isPresented: $isPrivacyPolicyPresented) {
                            PrivacyPolicyView(isSheetPresented: $isPrivacyPolicyPresented)
                        }
                        
                        SettingsListItem(text: "Terms and conditions", clickAction: {
                            isTermsAndConditionsPresented.toggle()
                        })
                        .sheet(isPresented: $isTermsAndConditionsPresented) {
                            TermsAndConditionsView(isSheetPresented: $isTermsAndConditionsPresented)
                        }
                        
                        Divider()
                        
                        LargeFilledButton(text: "Sign out", color: .gray, action: {
                            Preferences.deleteCredentials()
                            withAnimation {
                                viewModel.setScreen(to: .landing)
                            }
                        })
                        .padding(.top, 8)
                        
                        LargeFilledButton(text: "Delete Account", color: .pink, action: {
                            isShowingDeleteConfirmation = true
                        })
                        .padding(.top, 8)
                        .confirmationDialog("DELETE ACCOUNT",
                          isPresented: $isShowingDeleteConfirmation) {
                          Button("Permanently delete account", role: .destructive) {
                              Preferences.deleteCredentials()
                              withAnimation {
                                  viewModel.setScreen(to: .landing)
                              }
                          }
                        } message: {
                          Text("Are you sure you want to delete your account and all data associated with it? This action is irreversible.")
                        }
                    }
                }
                .padding(16)
            }
            
            if isActive {
                
            }
            
            if isCustomDialog {
                
            }
        }
    }
}

struct SettingsListItem: View {
    var text: String
    var clickAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: clickAction, label: {
                Text(text)
                Spacer()
                Image(systemName: "chevron.right")
            })
            .background(Color(UIColor.systemBackground))
            .frame(height: 16)
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 15).onTapGesture {
            clickAction()
        }
    }
}

struct AboutView: View {
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("ThoughtBank")
                    .font(
                        Font.custom("SmoochSans-ExtraBold", size: 48)
                    )
                    .padding(16)
                HStack {
                    Spacer()
                    Image("tbicon")
                        .resizable()
                        .frame(width: 128, height: 128)
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                    Spacer()
                }
                .padding(16)
                HStack {
                    Text("Development Team")
                        .font(
                            Font.custom("SmoochSans-ExtraBold", size: 32)
                        )
                    Spacer()
                }
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16))
                
                TeamMemberView(image: nil, name: "Abdulaziz Albahar", description: "Senior Tech Lead")
                TeamMemberView(image: nil, name: "Hsiang-Pin Ko", description: "Senior Developer")
                TeamMemberView(image: nil, name: "Steven Liu", description: "Senior Developer")
                TeamMemberView(image: nil, name: "Noah Sadir", description: "Senior Developer")
                TeamMemberView(image: nil, name: "Melanie Chen", description: "Designer")
                TeamMemberView(image: nil, name: "Laksh Makhija", description: "Developer")
                TeamMemberView(image: nil, name: "Tuan Cai", description: "Developer")
                TeamMemberView(image: nil, name: "Jordan Miao", description: "Developer")
                TeamMemberView(image: nil, name: "Ethan Kim", description: "Developer")
                TeamMemberView(image: nil, name: "Janah Abu Hassan", description: "Developer")
                TeamMemberView(image: nil, name: "Soham Shetty", description: "Developer")
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("About Us")
            .toolbar {
                Button("Done") {
                    isSheetPresented = false
                }
            }
        }
    }
}

struct TeamMemberView: View {
    let image: String?
    let name: String
    let description: String
    
    var body: some View {
        HStack {
            if let image = image {
                Image(image)
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            VStack {
                Text(name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(
                        Font.custom("Poppins-Bold", size: 18)
                    )
                Text(description)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

struct PrivacyPolicyView: View {
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ullamcorper malesuada proin libero nunc consequat interdum. Porttitor lacus luctus accumsan tortor posuere. Malesuada proin libero nunc consequat. Neque ornare aenean euismod elementum nisi quis. A condimentum vitae sapien pellentesque. Nibh sed pulvinar proin gravida hendrerit lectus. Auctor augue mauris augue neque gravida in. Tincidunt ornare massa eget egestas. Sit amet nisl purus in. Urna neque viverra justo nec. Morbi leo urna molestie at elementum eu facilisis. Massa vitae tortor condimentum lacinia quis vel. Turpis massa sed elementum tempus egestas sed sed risus pretium. Integer malesuada nunc vel risus commodo viverra maecenas accumsan. Vitae purus faucibus ornare suspendisse.")
                    .padding(16)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Privacy Policy")
            .toolbar {
                Button("Done") {
                    isSheetPresented = false
                }
            }
        }
    }
}

struct TermsAndConditionsView: View {
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ullamcorper malesuada proin libero nunc consequat interdum. Porttitor lacus luctus accumsan tortor posuere. Malesuada proin libero nunc consequat. Neque ornare aenean euismod elementum nisi quis. A condimentum vitae sapien pellentesque. Nibh sed pulvinar proin gravida hendrerit lectus. Auctor augue mauris augue neque gravida in. Tincidunt ornare massa eget egestas. Sit amet nisl purus in. Urna neque viverra justo nec. Morbi leo urna molestie at elementum eu facilisis. Massa vitae tortor condimentum lacinia quis vel. Turpis massa sed elementum tempus egestas sed sed risus pretium. Integer malesuada nunc vel risus commodo viverra maecenas accumsan. Vitae purus faucibus ornare suspendisse.")
                    .padding(16)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Terms and Conditions")
            .toolbar {
                Button("Done") {
                    isSheetPresented = false
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
