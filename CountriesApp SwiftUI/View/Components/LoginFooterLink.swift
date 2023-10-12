//
//  LoginFooterLink.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/12/23.
//

import SwiftUI

struct LoginFooterLink: View {
    var message: String
    var span: String
    
    
    var body: some View {
        HStack{
            Text(message)
                .foregroundColor(.gray)            
            Text(span)
                .foregroundColor(Color("AppMainColor"))
                .bold()
            
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
    }
}

struct LoginFooterLink_Previews: PreviewProvider {
    static var previews: some View {
        LoginFooterLink(
            message: "Não possui conta?",
            span: "Cadastre"
        )
    }
}
