//
//  RoundedTextField.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/12/23.
//

import SwiftUI

struct RoundedTextField: View {
    var placeholder: String
    @Binding var text: String
    var isPassword: Bool = false
    
    @State var showPassword: Bool = false
    
    var empty: Bool {text.isEmpty}
    
    var body: some View {
        HStack(spacing: 4){
            ZStack{
                TextField(placeholder, text: $text)
                    .opacity(!isPassword || showPassword ? 1 : 0)
                
                if isPassword{
                    SecureField(placeholder, text: $text)
                        .opacity(showPassword ? 0 : 1)
                }
            }
            
            if isPassword{
                Button(action: toggle){
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                }
                .foregroundColor(Color(uiColor: .tertiaryLabel))
                
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background{
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: empty ? 1 : 2)
                .foregroundColor(empty ? Color(uiColor: .systemGray2) : Color("lightPurple"))
        }
    }
    
    func toggle(){
        showPassword.toggle()
    }
}
