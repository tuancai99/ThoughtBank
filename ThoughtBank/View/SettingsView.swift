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
        VStack {
            HStack {
                Text("Given Alias:").frame(maxWidth: .infinity, alignment: .leading).padding(.vertical, 5).frame(width: UIScreen.main.bounds.size.width * 0.26).bold().font(.system(size: 18))
                Text("SurfCup30").frame(maxWidth: .infinity, alignment: .leading).padding(.vertical, 5).italic().font(.system(size: 18))
            }.padding(.top, 20)
            HStack {
                Text("Thoughts Remaining Today:").frame(maxWidth: .infinity, alignment: .leading).padding(.vertical, 5).frame(width: UIScreen.main.bounds.size.width * 0.6).bold().font(.system(size: 18))
                Text("0").frame(maxWidth: .infinity, alignment: .leading).padding(.vertical, 5).italic().font(.system(size: 18))
            }
            Divider().padding(.horizontal, -20)
            Text("Account Settings").frame(maxWidth: .infinity, alignment: .leading).padding(.vertical, 15).foregroundColor(Color(hex: 0xADADAD))
                VStack {
                    HStack {
                        Button("View profile") {
                            isProfilePresented.toggle()
                        }.frame(maxWidth: .infinity, alignment: .leading)
                            .buttonStyle(PlainButtonStyle())
                        Image(systemName: "chevron.right")
                    }.padding(.vertical, 15).contentShape(Rectangle()).onTapGesture {
                        isProfilePresented.toggle()
                    }.sheet(isPresented: $isProfilePresented) {
                        ProfileView(isSheetPresented: $isProfilePresented)
                    }.font(.system(size: 18))
                    HStack {
                        Text("Push notifications").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 18))
                        Toggle("", isOn: $isToggleOn)
                            .labelsHidden()
                            .tint(Color(hex: 0xFF4141))
                    }.padding(.vertical, 15)
                }
            Divider().padding(.horizontal, -20)
            Text("More").frame(maxWidth: .infinity, alignment: .leading).foregroundColor(Color(hex: 0xADADAD)).padding(.vertical, 15).font(.system(size: 18))
            VStack {
                HStack {
                    Button("About us") {
                        isAboutUsPresented.toggle()
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .buttonStyle(PlainButtonStyle())
                    Image(systemName: "chevron.right")
                }.padding(.vertical, 15).contentShape(Rectangle()).onTapGesture {
                    isAboutUsPresented.toggle()
                }.sheet(isPresented: $isAboutUsPresented) {
                    AboutView(isSheetPresented: $isAboutUsPresented)
                }.font(.system(size: 18))
                HStack {
                    Button("Privacy policy") {
                        isPrivacyPolicyPresented.toggle()
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .buttonStyle(PlainButtonStyle())
                    Image(systemName: "chevron.right")
                }.padding(.vertical, 15).contentShape(Rectangle()).onTapGesture {
                    isPrivacyPolicyPresented.toggle()
                }.sheet(isPresented: $isPrivacyPolicyPresented) {
                    PrivacyPolicyView(isSheetPresented: $isPrivacyPolicyPresented)
                }.font(.system(size: 18))
                HStack {
                    Button("Terms and conditions") {
                        isTermsAndConditionsPresented.toggle()
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .buttonStyle(PlainButtonStyle())
                    Image(systemName: "chevron.right")
                }.padding(.vertical, 15).contentShape(Rectangle()).onTapGesture {
                    isTermsAndConditionsPresented.toggle()
                }.sheet(isPresented: $isTermsAndConditionsPresented) {
                    TermsAndConditionsView(isSheetPresented: $isTermsAndConditionsPresented)
                }.font(.system(size: 18))
            }
            VStack {
                Spacer()
                Button {
                    isActive = true
                } label: {
                    Text("Delete Account").foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .padding()
                        .background(Color(hex: 0xFF4141))
                        .cornerRadius(10)
                        .font(.system(size: 18))
                }
                HStack(alignment: .bottom) {
                    VStack {
                        Image(systemName: "text.book.closed")
                        Text("Browse").font(.system(size: 12))
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "house")
                        Text("My Notes").font(.system(size: 12))
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share").font(.system(size: 12))
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search").font(.system(size: 12))
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "gearshape")
                        Text("Settings").font(.system(size: 12))
                    }
                }.padding(.top, 20).frame(maxWidth: .infinity)
            }.padding(.bottom, -20)
        }.padding(20)
            if isActive {
                CustomDialog(isActive: $isActive, isCustomDialog: $isCustomDialog, title: "Still want to delete your account?", message: "Note: This action cannot be changed", buttonTitle: "Give Access") {
                }
            }
            if isCustomDialog {
                CustomDialog2(isActive: $isActive, isCustomDialog: $isCustomDialog, title: "Successfully deleted!", message: "We are sorry to hear you deleted your account. Please note this request may take up to 15 days to go through", buttonTitle: "") {
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

struct CustomDialog: View {
    @Binding var isActive: Bool
    @Binding var isCustomDialog: Bool

    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> ()
    @State private var offset: CGFloat = UIScreen.main.bounds.height / 2

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
                .onTapGesture {
                    close()
                }

            VStack {
                Spacer()
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding()
                
                Text(message)
                    .font(.body).padding(.bottom, 30).foregroundColor(Color(hex: 0x54595E))
                HStack {
                    Button {
                        close()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(hex: 0x4F4F4F), lineWidth: 1)
                                )
                            Text("No, cancel")
                                .foregroundColor(.black)
                        }
                    }
                    Button {
                        isCustomDialog = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(hex: 0xFF0000))
                            
                            Text("Yes, confirm")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                        }
                    }
                }.padding(.bottom, 20)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(alignment: .topTrailing) {
                Button {
                    close()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                .tint(.black)
                .padding()
            }
            .shadow(radius: 20)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
        .ignoresSafeArea()
    }

    func close() {
        withAnimation(.spring()) {
            offset = UIScreen.main.bounds.height / 2
            isActive = false
        }
    }
}

struct CustomDialog_Previews: PreviewProvider {
    static var previews: some View {
        CustomDialog(isActive: .constant(true), isCustomDialog: .constant(false), title: "Still want to delete your account?", message: "Note: This action cannot be changed", buttonTitle: "Give Access", action: {})
    }
}

struct CustomDialog2: View {
    @Binding var isActive: Bool
    @Binding var isCustomDialog : Bool

    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> ()
    @State private var offset: CGFloat = UIScreen.main.bounds.height / 2

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
                .onTapGesture {
                    close2()
                }

            VStack {
                ZStack {
                    Circle()
                        .fill(Color.white) // Change the color of the circle as needed
                        .frame(width: 40, height: 40).overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(hex: 0x4F4F4F), lineWidth: 3)
                        )// Adjust the size of the circle

                    Image(systemName: "checkmark")
                        .foregroundColor(.black)
                        .font(.system(size: 24, weight: .bold))
                }.padding()
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding()
                
                Text(message)
                    .font(.body).padding(.bottom, 15).foregroundColor(Color(hex: 0x54595E))
                    Button {
                        close2()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(hex: 0x4F4F4F))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(hex: 0x4F4F4F), lineWidth: 1)
                                )
                            Text("Exit")
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    Button {
                        isCustomDialog = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white).overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(hex: 0x4F4F4F), lineWidth: 1)
                                )
                            
                            Text("Undo")
                                .foregroundColor(Color(hex: 0x4F4F4F))
                                .padding()
                        }
                    }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(alignment: .topTrailing) {
                Button {
                    close2()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                .tint(.black)
                .padding()
            }
            .shadow(radius: 20)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
        .ignoresSafeArea()
    }

    func close2() {
        withAnimation(.spring()) {
            offset = UIScreen.main.bounds.height / 2
            isActive = false
            isCustomDialog = false
        }
    }
}

struct CustomDialog2_Previews: PreviewProvider {
    static var previews: some View {
        CustomDialog2(isActive: .constant(false), isCustomDialog: .constant(true), title: "Successfully deleted!", message: "We are sorry to hear you deleted your account. Please note this request may take up to 15 days to go through", buttonTitle: "") {
        }
    }
}

struct ProfileView: View {
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        ZStack {
                    Text("Profile")
                    
                    Button("Done") {
                        isSheetPresented = false
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                }
        Spacer()
    }
}

struct AboutView: View {
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        ZStack {
                    Text("About Us")
                    
                    Button("Done") {
                        isSheetPresented = false
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                }
        Spacer()
    }
}

struct PrivacyPolicyView: View {
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        ZStack {
                    Text("Privacy Policy")
                    
                    Button("Done") {
                        isSheetPresented = false
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                }
        Spacer()
    }
}

struct TermsAndConditionsView: View {
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        ZStack {
                    Text("Terms and Conditions")
                    
                    Button("Done") {
                        isSheetPresented = false
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                }
        Spacer()
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0,
            opacity: alpha
        )
    }
}
