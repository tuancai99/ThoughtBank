//
//  ImageTextField.swift
//  ThoughtBank
//
//  Created by Noah Sadir on 11/14/23.
//

import SwiftUI

struct ImageTextField: View {
    @Binding var text: String
    var placeholder: String
    var image: String
    var secure: Bool = false
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(height: 52)
            .background(.quinary)
            .cornerRadius(13)
            .overlay(
                HStack {
                    Image(systemName: image)
                        .font(.title3)
                    .colorMultiply(.secondary)
                    .padding(.trailing, 10)
                    
                    if secure {
                        SecureField(text: $text, prompt: Text(placeholder).foregroundColor(.gray), label: {})
                            .foregroundColor(.primary)
                            

                    } else {
                        TextField(text: $text, prompt: Text(placeholder).foregroundColor(.gray), label: {})
                            .foregroundColor(.primary)

                    }
                }
                .padding()
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
            )
        
        
    }
}

struct ImageTextField_Previews: PreviewProvider {
    @State var text: String
    static var previews: some View {
        ImageTextField(text: .constant(""), placeholder: "Placeholder", image: "lock.fill")
    }
}
