//
//  ProgressOverlay.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 11/15/23.
//

import SwiftUI

struct ProgressOverlay: View {
    @Binding var isVisible: Bool
    
    var body: some View {
        ZStack {
            if isVisible {
                Rectangle()
                    .fill(Color.black).opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .fill(.thickMaterial)
                    ProgressView()
                }
                .frame(width: 64, height: 64)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProgressOverlay(isVisible: .constant(true))
}
