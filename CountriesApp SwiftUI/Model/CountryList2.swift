//
//  CountryList2.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/13/23.
//

import Foundation

struct CountryList2: Codable{
    var cca2: String
    var namePt: String
    var nameUs: String
    var nameEs: String
    var flagPng: String
    var flagSvg: String
    
    func toDictionary() -> [String: Any] {
        return [
            "cca2": cca2,
            "namePt": namePt,
            "nameUs": nameUs,
            "nameEs": nameEs,
            "flagPng": flagPng,
            "flagSvg": flagSvg
        ]
    }
}
