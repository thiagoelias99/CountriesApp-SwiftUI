//
//  CountryMapTab.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/13/23.
//

import SwiftUI
import MapKit

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

struct CountryMapTab: View {
    var country: CountryInfo?
    
    @State private var location = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    private struct Point: Identifiable{
        var id = UUID()
        var name: String
        var latitude: Double
        var longitude: Double
        
        var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    var body: some View {
        if let country {
            Map(coordinateRegion: $location,
                annotationItems: [
                Point(
                    name: country.namePt,
                    latitude: country.latitude,
                    longitude: country.longitude
                )]
            ){ point in
                MapMarker(coordinate: point.coordinate)
            }
            .onAppear(){
                var coordinates = CLLocationCoordinate2D(latitude: country.latitude, longitude: country.longitude)
                
                location = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 30.0, longitudeDelta: 30.0))
            }
        } else {
            Text("Carregando")
        }
    }
}

struct CountryMapTab_Previews: PreviewProvider {
    static var previews: some View {
        CountryMapTab(
            country: mockCountryApi
        )
    }
}
