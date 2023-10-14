//
//  Global.swift
//  CountriesApp SwiftUI
//
//  Created by Thiago Elias on 10/13/23.
//

import Foundation

var userId: String? = nil

//Mock da resposta da API, getByCCA2
var mockCountryApi = CountryInfo(
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

//Mock da reposta de lista de países da API
var mockApi = [
    CountryList2(cca2: "BR", namePt: "Brasil", nameUs: "Brazil", nameEs: "Brasil", flagPng: "https://flagcdn.com/w320/br.png", flagSvg: "https://flagcdn.com/br.svg"),
    CountryList2(cca2: "GI", namePt: "Gibraltar", nameUs: "Gibraltar", nameEs: "Gibraltar", flagPng: "https://flagcdn.com/w320/gi.png", flagSvg: "https://flagcdn.com/w320/gi.png"),
    CountryList2(cca2: "AU", namePt: "Australia", nameUs: "Australia", nameEs: "Australia", flagPng: "https://flagcdn.com/w320/au.png", flagSvg: "https://flagcdn.com/w320/au.png")
]
