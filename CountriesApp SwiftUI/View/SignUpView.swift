//
//  SignUpView.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/12/23.
//

import SwiftUI

struct SignUpView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordCheck: String = ""
    
    var body: some View {
        VStack(alignment: .center){
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 160)
            
            VStack(alignment: .leading){
                Text("Crie sua conta")
                    .font(.title)
                    .bold()
                RoundedTextField(placeholder: "Seu nome", text: $email)
                RoundedTextField(placeholder: "Seu email", text: $email)
                RoundedTextField(placeholder: "Digite uma senha", text: $password, isPassword: true)
                RoundedTextField(placeholder: "Repita a senha", text: $password, isPassword: true)
                StyledButton(placeholder: "Criar conta")
                NavigationLink(destination: LoginView()){
                    LoginFooterLink(message: "Já possui conta?", span: "Entre")
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .background(Color("AppMainLightColor"))
            .clipShape(RoundedRectangle(cornerRadius: 20)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("AppMainColor"), lineWidth: 2)
            )
            Spacer()
            Owner()
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
