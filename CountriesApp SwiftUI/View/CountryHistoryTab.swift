//
//  CountryHistoryTab.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/13/23.
//

import SwiftUI

private var mockCountryApi = CountryInfo(
    area: 8515767,
    capitalsPt: ["Brasília"],
    cca2: "BR",
    cca3: "BRA",
    coatOfArmsPng: "https://mainfacts.com/media/images/coats_of_arms/br.png",
    currencyNamePt: "Real brasileiro",
    currencySymbol: "R$",
    flagPng: "https://flagcdn.com/w320/br.png",
    historyPt: "Maior país da América do Sul, com vasta área de litoral banhada pelo oceano Atlântico.",
    languages: ["Portuguese"],
    latitude: -15.79,
    longitude: -47.88,
    nameCompletePt: "República Federativa do Brasil",
    namePt: "Brasil",
    population: 212559409,
    regionPt: "América do sul")

struct CountryHistoryTab: View {
    var country: CountryInfo?
    
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
        CountryHistoryTab(country: mockCountryApi)
    }
}
