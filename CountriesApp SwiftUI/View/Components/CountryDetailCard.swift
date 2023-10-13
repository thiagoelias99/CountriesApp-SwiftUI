//
//  CountryDetailCard.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/13/23.
//

import SwiftUI

struct CountryDetailCard: View {
    var title: String
    var caption: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(title)
                    .font(.title2)
                    .bold()
                Text(caption)
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color("AppMainColor"))
            }
            Spacer()
        }
        .padding(.top, 4)
    }
}

struct CountryDetailCard_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailCard(
        title: "Capital", caption: "Brasília"
        )
    }
}
