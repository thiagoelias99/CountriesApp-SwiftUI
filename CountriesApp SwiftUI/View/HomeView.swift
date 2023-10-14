//
//  HomeView.swift
//  CountriesApp SwiftUI
//
//  Created by Thiago Elias on 10/12/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct HomeView: View {
    let db = Firestore.firestore()
    
    @State var enteredText: String = ""
    @State var countryLIstFromApi: [CountryList2] = []
    @State var showSheet: Bool = false
    @State var countryList: [CountryList2] = []
    @State var goToLoginView: Bool = false
    @State var user: User?
    @State var selectedCountry: CountryList2?
    @State var goToTabView: Bool = false
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Olá \(user?.name ?? "")")
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
                            .onLongPressGesture(){
                                selectedCountry = country
                                showDeleteAlert = true
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
        //Sheet de seleção de país
        .sheet(isPresented: $showSheet){
            VStack{
                Text("Procure pelo nome do país")
                    .font(.body)
                    .padding(.top, 4)
                    .bold()
                TextField("", text: $enteredText)
                    .font(.body)
                    .autocapitalization(.none)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .border(Color("AppMainColor"))
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("AppMainColor"), lineWidth: 1)
                    )
                    .onChange(of: enteredText){newText in loadCountries(text: newText)}
                ScrollView{
                    ForEach(countryLIstFromApi, id: \.cca2){country in
                        CountryCard(country: country)
                            .onTapGesture {
                                countryList.append(country)
                                updateUser()
                                showSheet = false
                            }
                    }
                }
            }
            .padding(16)
        }
        .onAppear(){
            getUserData()
        }
        .alert(isPresented: $showDeleteAlert){
            Alert(
                title: Text("Quer realmente deletar o país \(selectedCountry?.namePt ?? "") ?"),
                primaryButton: .default(
                    Text("Cancelar"),
                    action: {}
                ),
                secondaryButton: .destructive(
                    Text("Deletar"),
                    action: deleteCountry
                )
            )
        }
    }

    //Função que executa no sheet para procurar país, a partir de 3 letras
    private func loadCountries(text: String){
        if(text.count < 3){
            return
        }
        
        let requestURL = "https://countriesapp-backend.onrender.com/countries/\(text)"
        guard let url = URL(string: requestURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, error in
            guard let data = data else { return }
            
            print(data)
            
            let decoder = JSONDecoder()
            
            do {
                countryLIstFromApi = try decoder.decode([CountryList2].self, from: data)
                print(countryLIstFromApi)
            } catch {
                print("Erro na leitura da API: \(error)")
            }
        }.resume()
    }
    
    //Carrega do firebase informação do usuário ao carregar a tela
    //Se usuário não estiver logado/existir volta para tela de login
    private func getUserData(){
        guard let userId else { return }
        
        let docRef = db.collection("users").document(userId)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var data = document.data()
                
                if let name = data?["name"] as? String,
                   let email = data?["email"] as? String
                {
                    var userFB = User(
                        id: document.documentID,
                        name: name,
                        email: email,
                        countries: []
                    )
                    
                    if let countries = data?["countries"] as? [[String: Any]]{
                        for country in countries{
                            if let cca2 = country["cca2"] as? String,
                               let flagPng = country["flagPng"] as? String,
                               let flagSvg = country["flagSvg"] as? String,
                               let nameEs = country["nameEs"] as? String,
                               let nameUs = country["nameUs"] as? String,
                               let namePt = country["namePt"] as? String
                            {
                                userFB.countries.append(CountryList2(
                                    cca2: cca2,
                                    namePt: namePt,
                                    nameUs: nameUs,
                                    nameEs: nameEs,
                                    flagPng: flagPng,
                                    flagSvg: flagSvg)
                                )
                            }
                        }
                    }
                    user = userFB
                    countryList = user?.countries ?? []
                }
                
            } else {
                print("Usuário não encontrado")
                goToLoginView = true
            }
        }
    }
    
    //Atualiza o usuário no firebase
    func updateUser(){
        guard var newUser = user else {return}
        newUser.countries = countryList
        let docRef = db.collection("users").document(newUser.id)
        
        docRef.setData(newUser.toDictionary()) { err in
            if let err = err {
                print("Error setting document: \(err)")
            }
        }
    }
    
    //Deleta pais da lista e atualiza firebase
    private func deleteCountry(){
        countryList.removeAll(){ item in
            item.cca2 == selectedCountry?.cca2
        }
        updateUser()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(countryList: mockApi)
    }
}
