//
//  Owner.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/12/23.
//

import SwiftUI

struct Owner: View {
    var body: some View {
        HStack{
            Text("Desenvolvido por")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.trailing, 0)
            Text("Thiago Elias")
                .font(.caption)
                .bold()
                .foregroundColor(.gray)
                .padding(.leading, 0)
        }
        .padding(.top, 10)
    }
}

struct Owner_Previews: PreviewProvider {
    static var previews: some View {
        Owner()
    }
}
