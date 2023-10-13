//
//  TabNavigationView.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/12/23.
//

import SwiftUI

struct CountryInfo: Codable{
    var area: Double
    var capitalsPt: [String]
    var cca2: String
    var cca3: String
    var coatOfArmsPng: String
    var currencyNamePt: String
    var currencySymbol: String
    var flagPng: String
    var historyPt: String
    var languages: [String]
    var latitude: Double
    var longitude: Double
    var nameCompletePt: String
    var namePt: String
    var population: Int
    var regionPt: String
}

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



struct TabNavigationView: View {
    var countryCCA2: String
    @State var country: CountryInfo?
    @State var goToHomeView: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                NavigationLink(destination: HomeView()){
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .foregroundColor(.black)
                        .bold()
                }
                Text(countryCCA2)
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(Color("AppMainLightColor"))
            TabView{
                CountryDetailsTab(country: $country)
                    .tabItem(){
                        Group{
                            Image(systemName: "info.circle")
                                .foregroundColor(.black)
                            Text("Infos")
                                .foregroundColor(.black)
                        }
                    }
                CountryMapTab(country: $country)
                    .tabItem(){
                        Group{
                            Image(systemName: "map.circle.fill")
                                .foregroundColor(.black)
                            Text("Localização")
                                .foregroundColor(.black)
                        }
                    }
                CountryHistoryTab(country: $country)
                    .tabItem(){
                        Group{
                            Image(systemName: "book.circle.fill")
                                .foregroundColor(.black)
                            Text("História")
                                .foregroundColor(.black)
                        }
                    }
            }
            .onAppear(){
                UITabBar.appearance().backgroundColor = UIColor(Color("AppMainLightColor"))
            }
            .tint(.black)
        }
        .onAppear(){loadCountry(cca2: countryCCA2)}
        .navigationBarBackButtonHidden(true)
    }
    
    func loadCountry(cca2: String){
        let requestURL = "https://countriesapp-backend.onrender.com/countries/cca2/\(cca2)"
        guard let url = URL(string: requestURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, error in
               guard let data = data else { return }
               
               let decoder = JSONDecoder()
               
               do {
                   country = try decoder.decode(CountryInfo.self, from: data)
               } catch {
                   print("Erro na leitura da API: \(error)")
               }
           }.resume()
    }
}

struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigationView(countryCCA2: "BR")
    }
}
