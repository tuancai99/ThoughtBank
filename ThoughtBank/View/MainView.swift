//
//  MainView.swift
//  ThoughtBank
//
//  Created by Songyuan Liu on 10/29/23.
//

import SwiftUI

enum LandingPageOption {
    case Public, Personal, Saved
}

struct MainView<ViewModel: ViewModelProtocol>: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var tabSelection: NavigationState = .feedThoughts
    
    //@State var landingPageOption: String
    
    //let LandingPageOptions = ["Public", "Personal", "Saved"]
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "SmoochSans-ExtraBold", size: 48) ?? .systemFont(ofSize: 32, weight: .bold)]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "SmoochSans-ExtraBold", size: 24) ?? .systemFont(ofSize: 32, weight: .bold)]
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: "Poppins-Regular", size: 12)! ], for: .normal)
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                Divider()
                /*
                 VStack {
                 Picker("hello", selection: $landingPageOption) {
                 ForEach(LandingPageOptions, id: \.self) {
                 Text($0)
                 }
                 }
                 .pickerStyle(.segmented)
                 }
                 .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 50)
                 */
                TabView(selection: $tabSelection) {
                    MainFeedView<ViewModel>()
                        .tabItem {
                            Label("Browse", systemImage: "magnifyingglass.circle")
                        }
                        .tag(NavigationState.feedThoughts)
                    
                    PersonalThoughtsView<ViewModel>()
                        .tabItem {
                            Label("My Thoughts", systemImage: "square.and.arrow.up")
                        }
                        .tag(NavigationState.ownedThoughts)
                    
                    DepositedThoughtsView<ViewModel>()
                        .tabItem {
                            Label("Deposited", systemImage: "square.and.arrow.down")
                        }
                        .tag(NavigationState.depositedThoughts)
                    
                    SettingsView<ViewModel>()
                        .tabItem {
                            Label("Settings", systemImage: "gearshape")
                        }
                        .tag(NavigationState.settings)
                }
                .onChange(of: tabSelection, perform: { state in
                    viewModel.navigationState = state
                })
                .navigationTitle(viewModel.navigationState.rawValue)
                
                /*
                // A little cluttered and not utilized
                .toolbar {
                    Button {
                        
                    } label: {
                        Label("FontSize", systemImage: "textformat.size")
                        
                    }
                }
                .toolbar {
                    Button {
                        
                    } label: {
                        Label("Audio", systemImage: "speaker.wave.2")
                    }
                }
                .toolbar {
                    Button {
                        
                    } label: {
                        Label("Bookmark", systemImage: "bookmark")
                    }
                    
                }
                 */
                
            }
            ProgressOverlay(isVisible: $viewModel.shouldLoadBlocking)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView<PreviewViewModel>().environmentObject(PreviewViewModel())
            .environment(\.font, Font.custom("Poppins-Regular", size: 14))
    }
}
