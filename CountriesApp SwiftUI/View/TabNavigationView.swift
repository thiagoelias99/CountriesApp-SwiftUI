//
//  TabNavigationView.swift
//  CountriesApp SwiftUI
//
//  Created by Thiago Elias on 10/12/23.
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
                Text("voltar")
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(Color("AppMainLightColor"))
            TabView{
                //Primeiro abre por padrão
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
                //Background do seletor de tabs
                UITabBar.appearance().backgroundColor = UIColor(Color("AppMainLightColor"))
            }
            //Cor do ícone e texto do seletor
            .tint(.black)
        }
        .onAppear(){loadCountry(cca2: countryCCA2)}
        .navigationBarBackButtonHidden(true)
    }
    
    //Busca as informação do país no back pelo cód cca2
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
