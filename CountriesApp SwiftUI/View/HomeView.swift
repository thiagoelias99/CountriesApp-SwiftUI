//
//  HomeView.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/12/23.
//

import SwiftUI

var mockApi = [
    CountryList2(cca2: "BR", namePt: "Brasil", nameUs: "Brazil", nameES: "Brasil", flagPng: "https://flagcdn.com/w320/br.png", flagSvg: "https://flagcdn.com/br.svg"),
    CountryList2(cca2: "GI", namePt: "Gibraltar", nameUs: "Gibraltar", nameES: "Gibraltar", flagPng: "https://flagcdn.com/w320/gi.png", flagSvg: "https://flagcdn.com/w320/gi.png"),
    CountryList2(cca2: "AU", namePt: "Australia", nameUs: "Australia", nameES: "Australia", flagPng: "https://flagcdn.com/w320/au.png", flagSvg: "https://flagcdn.com/w320/au.png")
]

struct CountryList2: Codable{
    var cca2: String
    var namePt: String
    var nameUs: String
    var nameES: String
    var flagPng: String
    var flagSvg: String
}

struct HomeView: View {    
    //Sheet handler
    @State var enteredText: String = ""
    @State var countryLIstFromApi: [CountryList2] = mockApi
    @State var showSheet: Bool = false
    @State var countryList: [CountryList2] = []
    @State var goToLoginView: Bool = false
    @State var userName: String = "Thiago"
    
    @State var selectedCountry: CountryList2?
    @State var goToTabView: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Olá \(userName)")
                    .foregroundColor(.black)
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: {
                    goToLoginView = true
                }){
                    Image(systemName: "return.right")
                        .foregroundColor(.black)
                        .bold()
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 92)
            .background(Color("AppMainLightColor"))
            
            VStack(alignment: .leading){
                Text("Minha lista de países")
                    .bold()
                
                ScrollView{
                    ForEach(countryList, id: \.cca2){ country in
                        CountryCard(country: country)
                            .onTapGesture(){
                                selectedCountry = country
                                goToTabView = true
                            }
                    }
                }
                StyledButton(placeholder: "Adicionar País"){showSheet = true}
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .padding(.vertical, 48)
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $goToLoginView){LoginView()}
        .navigationDestination(isPresented: $goToTabView){
            TabNavigationView(countryCCA2: selectedCountry?.cca2 ?? "")}
        .sheet(isPresented: $showSheet){
            VStack{
                RoundedTextField(placeholder: "Procure pelo nome do país", text: $enteredText)
                ScrollView{
                    ForEach(countryLIstFromApi, id: \.cca2){country in
                        CountryCard(country: country)
                            .onTapGesture {
                                countryList.append(country)
                                showSheet = false
                            }
                    }
                }
            }
            .padding(16)

        }
        .onAppear(){
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            countryList: mockApi)
    }
}
