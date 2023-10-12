//
//  HomeView.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/12/23.
//

import SwiftUI

struct HomeView: View {
    var userName: String {
        "Thiago"
    }
    
    var countryList: [CountryList] = []
    
    @State var goToLoginView: Bool = false
    
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
                    }
                }
                StyledButton(placeholder: "Adicionar País")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .padding(.vertical, 48)
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $goToLoginView){
            LoginView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            countryList: [
                CountryList(cca2: "BR", namePt: "Brasil", nameUs: "Brazil", nameES: "Brasil", flagPng: "https://flagcdn.com/w320/br.png", flagSvg: "https://flagcdn.com/br.svg"),
                CountryList(cca2: "GI", namePt: "Gibraltar", nameUs: "Gibraltar", nameES: "Gibraltar", flagPng: "https://flagcdn.com/w320/gi.png", flagSvg: "https://flagcdn.com/w320/gi.png"),
                CountryList(cca2: "AU", namePt: "Australia", nameUs: "Australia", nameES: "Australia", flagPng: "https://flagcdn.com/w320/au.png", flagSvg: "https://flagcdn.com/w320/au.png")
            ])
    }
}
