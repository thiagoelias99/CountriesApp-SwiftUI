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
        VStack(alignment: .leading){
            Text(placeholder)
                .font(.body)
                .padding(.top, 4)
                .bold()
            HStack(spacing: 4){
                ZStack{
                    TextField("", text: $text)
                        .opacity(!isPassword || showPassword ? 1 : 0)
                        .font(.body)
                        .autocapitalization(.none)
                    
                    if isPassword{
                        SecureField("", text: $text)
                            .opacity(showPassword ? 0 : 1)
                            .font(.body)
                            .autocapitalization(.none)
                    }
                }
                
                if isPassword{
                    Button(action: toggle){
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    .foregroundColor(Color(uiColor: .tertiaryLabel))
                    
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .border(Color("AppMainColor"))
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("AppMainColor"), lineWidth: 1)
            )
        }
    }
    
    func toggle(){
        showPassword.toggle()
    }
}

struct RoundedTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 30){
            RoundedTextField(placeholder: "Email", text: .constant(""))
            RoundedTextField(placeholder: "Email", text: .constant("thiago@email.com"))
            RoundedTextField(placeholder: "Password", text: .constant(""))
            RoundedTextField(placeholder: "Password", text: .constant("123456"), isPassword: true)
        }
        
    }
}
