//
//  StyledButton.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/12/23.
//

import SwiftUI

struct StyledButton: View {
    var placeholder: String
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            (action ?? defaultAction)()
        }){
            Text(placeholder)
                .font(.body)
                .foregroundColor(.white)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .background(Color("AppMainColor"))
        .cornerRadius(10)
        .padding(.top)
        
    }
    
    func defaultAction(){
        print("Button \(placeholder) pressed!")
    }
}



struct StyledButton_Previews: PreviewProvider {
    static var previews: some View {
        StyledButton(
            placeholder: "Entrar"
        )
    }
}
