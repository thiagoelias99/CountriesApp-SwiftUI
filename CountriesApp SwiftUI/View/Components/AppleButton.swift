//
//  AppleButton.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/12/23.
//

import SwiftUI

struct AppleButton: View {
    var body: some View {
        Button(action: {}){
            HStack{
                Image(systemName: "apple.logo")
                    .tint(.white)
                Text("Continuar com Apple")
                    .font(.body)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .background(.black)
        .cornerRadius(10)
    }
}

struct AppleButton_Previews: PreviewProvider {
    static var previews: some View {
        AppleButton()
    }
}
