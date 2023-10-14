//
//  LoginView.swift
//  CountriesApp SwiftUI
//
//  Created by Thiago Elias on 10/12/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var rememberUser: Bool = true
    @State var goToHomeView: Bool = false
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    
    var body: some View {
        VStack(alignment: .center){
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            VStack(alignment: .leading){
                Text("Entre com sua conta")
                    .font(.title)
                    .bold()
                RoundedTextField(placeholder: "Email", text: $email)
                ZStack{
                    RoundedTextField(placeholder: "Senha", text: $password, isPassword: true)
                    HStack{
                        Spacer()
                        Text("Recuperar Senha")
                            .bold()
                            .foregroundColor(Color("AppMainColor"))
                    }
                    .offset(y: -25)
                }
                KeepConectedToggle(rememberUser: $rememberUser)
                StyledButton(placeholder: "Entrar"){login()}
                AppleButton()
                NavigationLink(destination: SignUpView()){
                    LoginFooterLink(message: "Não possui conta?", span: "Cadastre")
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 32)
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
        .navigationBarBackButtonHidden(true) //Para esconder a seta de back
        .navigationDestination(isPresented: $goToHomeView){ HomeView()}
        .alert(isPresented: $showAlert){
            Alert(title: Text("Falha no cadastro"), message: Text(alertMessage))
        }
    }
    
    func login(){
        if(password.isEmpty || email.isEmpty ){
            print("Todos os campos devem ser preeenchidos")
            alertMessage = "Todos os campos devem ser preeenchidos"
            showAlert = true
            return
        }
        
        //Faz auth com firebase e guarda o userId logado
        Auth.auth().signIn(withEmail: email, password: password){
            authResult, error in
            
            guard let user = authResult else {
                print(error?.localizedDescription ?? "Ocorreu um erro do Firebase")
                alertMessage = error?.localizedDescription ?? "Ocorreu um erro do Firebase"
                showAlert = true
                return
            }
            userId = Auth.auth().currentUser?.uid ?? nil
            goToHomeView = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
