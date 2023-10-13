//
//  CountryDetailTitleCard.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/13/23.
//

import SwiftUI

struct CountryDetailTitleCard: View {
    var countryName: String
    var cca3: String
    var completName: String
    
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("\(countryName) (\(cca3))")
                    .font(.title)
                    .bold()
                Text(completName)
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color("AppMainColor"))
            }
            Spacer()
        }
    }
}

struct CountryDetailTitleCard_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailTitleCard(
            countryName: "Brasil", cca3: "BRA", completName: "República Federativa do Brasil"
        )
    }
}
