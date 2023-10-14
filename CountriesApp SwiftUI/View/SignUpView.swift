//
//  SignUpView.swift
//  CountriesApp SwiftUI
//
//  Created by Thiago Elias on 10/12/23.
//

import SwiftUI

struct SignUpView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordCheck: String = ""
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    @State var goToLoginView: Bool = false
    
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
                RoundedTextField(placeholder: "Seu nome", text: $name)
                RoundedTextField(placeholder: "Seu email", text: $email)
                RoundedTextField(placeholder: "Digite uma senha", text: $password, isPassword: true)
                RoundedTextField(placeholder: "Repita a senha", text: $passwordCheck, isPassword: true)
                StyledButton(placeholder: "Criar conta", action: signUp)
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
        .navigationDestination(isPresented: $goToLoginView){LoginView()}
        .alert(isPresented: $showAlert){
            Alert(title: Text("Falha no cadastro"), message: Text(alertMessage))
        }
    }
    
    func signUp(){
        if(password != passwordCheck){
            alertMessage = "As senha não são iguais"
            showAlert = true
            return
        }
        if(name.isEmpty || email.isEmpty || password.isEmpty || passwordCheck.isEmpty){
            alertMessage = "Todos os campos devem ser preeenchidos"
            showAlert = true
            return
        }
        
        //Faz cadastro pelo backend
        let requestURL = "https://countriesapp-backend.onrender.com/signup"
        guard let url = URL(string: requestURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body: [String: String] = [
            "name": name,
            "email": email,
            "password": password
        ]
        
        //Stringfy do body
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("Erro ao criar dados JSON: \(error)")
            return
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Erro na solicitação POST: \(error?.localizedDescription ?? "Erro desconhecido")")
                return
            }
            //Retorno do back de sucesso é código 201
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 201 {
                    goToLoginView = true
                } else {
                    alertMessage = "Erro ao cadastrar \(httpResponse.statusCode)"
                    showAlert = true
                }
            }
        }.resume()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
