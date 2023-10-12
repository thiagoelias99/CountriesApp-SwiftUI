//
//  LoginView.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/12/23.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var rememberUser: Bool = true
    
    var body: some View {
        VStack(alignment: .center){
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding(.horizontal, 20)
            
            VStack(alignment: .leading){
                Text("Entre com sua conta")
                RoundedTextField(placeholder: "Email", text: $email)
                ZStack{
                    RoundedTextField(placeholder: "Senha", text: $password, isPassword: true)
                    HStack{
                        Spacer()
                        Text("Recuperar Senha")
                    }
                    .offset(y: -30)
                }
                KeepConectedToggle(rememberUser: $rememberUser)
                StyledButton(placeholder: "Entrar")
                AppleButton()
                LoginFooterLink(message: "Não possui conta?", span: "Cadastre")
            }
            .padding(.horizontal, 16)
            Owner()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
