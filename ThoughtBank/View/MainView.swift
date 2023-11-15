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
    //@State var landingPageOption: String
    
    //let LandingPageOptions = ["Public", "Personal", "Saved"]
    
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
                TabView {
                    MainFeedView<ViewModel>()
                        .tabItem {
                            Label("Browse", systemImage: "magnifyingglass.circle")
                        }
                    
                    PersonalThoughtsView<ViewModel>()
                        .tabItem {
                            Label("My Thoughts", systemImage: "square.and.arrow.up")
                        }
                    
                    DepositedThoughtsView<ViewModel>()
                        .tabItem {
                            Label("Deposited", systemImage: "square.and.arrow.down")
                        }
                    
                    SettingsView<ViewModel>()
                        .tabItem {
                            Label("Settings", systemImage: "gearshape")
                        }
                }
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
                
            }
            ProgressOverlay(isVisible: $viewModel.shouldLoadBlocking)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView<PreviewViewModel>().environmentObject(PreviewViewModel())
    }
}
