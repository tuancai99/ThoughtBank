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
    @State var landingPageOption: String
    
    let LandingPageOptions = ["Public", "Personal", "Saved"]

    var body: some View {
        NavigationStack {
            Divider()
            VStack {
                Picker("hello", selection: $landingPageOption) {
                    ForEach(LandingPageOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
            .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 50)
            
            TabView {
                MainFeedView<PreviewViewModel>()
                    .tabItem {
                        Label("Browse", systemImage: "magnifyingglass.circle")
                    }
                
                DepositedThoughtsView<PreviewViewModel>()
                    .tabItem {
                        Label("My Notes", systemImage: "house")
                    }
                
                AddThoughtsView<PreviewViewModel>()
                    .tabItem {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                
                LandingPageView<PreviewViewModel>()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                SettingsView<PreviewViewModel>()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
            .toolbar {
                Button {
                    
                } label: {
                    Label("Bookmark", systemImage: "textformat.size")
                        
                }
            }
            .toolbar {
                Button {
                    
                } label: {
                    Label("Bookmark", systemImage: "speaker.wave.2")
                }
            }
            .toolbar {
                Button {
                    
                } label: {
                    Label("Bookmark", systemImage: "bookmark")
                }
                
            }

        }
        
        
    }
}

#Preview {
    MainView<PreviewViewModel>(landingPageOption: "Public")
        .environmentObject(PreviewViewModel())
}
