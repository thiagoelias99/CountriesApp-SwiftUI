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
        .navigationDestination(isPresented: $goToLoginView){LoginView()}        .alert(isPresented: $showAlert){
            Alert(title: Text("Falha no cadastro"), message: Text(alertMessage))
        }
    }
    
    func signUp(){
        if(password != passwordCheck){
            print("As senha não são iguais")
            alertMessage = "As senha não são iguais"
            showAlert = true
            return
        }
        if(name.isEmpty || email.isEmpty || password.isEmpty || passwordCheck.isEmpty){
            print("Todos os campos devem ser preeenchidos")
            alertMessage = "Todos os campos devem ser preeenchidos"
            showAlert = true
            return
        }
        
        let requestURL = "https://countriesapp-backend.onrender.com/signup"
            guard let url = URL(string: requestURL) else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let parameters: [String: String] = [
                "name": name,
                "email": email,
                "password": password
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
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
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 201 {
                        // Requisição bem-sucedida
                        print("Requisição POST bem-sucedida")
                        goToLoginView = true
                    } else {
                        // Erro no servidor, manipule conforme necessário
                        print("Erro no servidor - Código de status: \(httpResponse.statusCode)")
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
