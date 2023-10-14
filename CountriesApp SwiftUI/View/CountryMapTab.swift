//
//  CountryMapTab.swift
//  CountriesApp SwiftUI
//
//  Created by Thiago Elias on 10/13/23.
//

import SwiftUI
import MapKit

struct CountryMapTab: View {
    @Binding var country: CountryInfo?
    
    @State private var location = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    
    //Estrutura para adicionar o marcador no mapa
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
                let coordinates = CLLocationCoordinate2D(latitude: country.latitude, longitude: country.longitude)
                
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
            country: .constant(mockCountryApi)
        )
    }
}
