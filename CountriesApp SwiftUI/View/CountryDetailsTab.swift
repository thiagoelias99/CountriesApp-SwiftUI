//
//  CountryDetailsTab.swift
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

struct CountryDetailsTab: View {
    var country: CountryInfo?    
    
    var body: some View {
        if let country {
            VStack{
                ZStack{
                    AsyncImage(url: URL(string: country.flagPng)) { image in
                        image
                            .resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 322, height: 192)
                    AsyncImage(url: URL(string: country.coatOfArmsPng)) { image in
                        image
                            .resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 92, height: 92)
                    .clipShape(RoundedRectangle(cornerRadius: 4)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color("AppMainColor"), lineWidth: 2)
                    )
                    .offset(x: 140, y: 95)
                }
                CountryDetailTitleCard(countryName: country.namePt, cca3: country.cca3, completName: country.nameCompletePt)
                ScrollView{
                    CountryDetailCard(title: "Capital", caption: country.capitalsPt[0])
                    CountryDetailCard(title: "Região", caption: country.regionPt)
                    CountryDetailCard(title: "Moeda", caption: "\(country.currencyNamePt) - \(country.currencySymbol)")
                    CountryDetailCard(title: "População", caption: String(country.population))
                    CountryDetailCard(title: "Área", caption: String(country.area))
                    CountryDetailCard(title: "Idiomas", caption: country.languages[0])
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 24)            
        } else{
            Text("Carregando")
        }
    }
}

struct CountryDetailsTab_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailsTab(
        country: mockCountryApi)
    }
}
