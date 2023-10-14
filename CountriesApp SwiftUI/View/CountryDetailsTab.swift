//
//  CountryDetailsTab.swift
//  CountriesApp SwiftUI
//
//  Created by Thiago Elias on 10/13/23.
//

import SwiftUI

struct CountryDetailsTab: View {
    @Binding var country: CountryInfo?
    
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
            country: .constant(mockCountryApi))
    }
}
