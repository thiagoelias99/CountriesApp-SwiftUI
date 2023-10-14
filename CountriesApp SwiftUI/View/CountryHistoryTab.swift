//
//  CountryHistoryTab.swift
//  CountriesApp SwiftUI
//
//  Created by Thiago Elias on 10/13/23.
//

import SwiftUI

struct CountryHistoryTab: View {
    @Binding var country: CountryInfo?
    
    var body: some View {
        if let country{
            VStack{
                HStack{
                    Text(country.namePt)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                ScrollView{
                    Text(country.historyPt)
                        .font(.title3)
                }
            }
            .padding(16)
        } else {
            Text("Carregando")
        }
    }
}

struct CountryHistoryTab_Previews: PreviewProvider {
    static var previews: some View {
        CountryHistoryTab(country: .constant(mockCountryApi))
    }
}
