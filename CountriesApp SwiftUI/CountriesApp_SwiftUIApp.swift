//
//  CountriesApp_SwiftUIApp.swift
//  CountriesApp SwiftUI
//
//  Created by Thiago Elias on 10/12/23.
//

import SwiftUI

@main
struct CountriesApp_SwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
        ContentView()
        }
    }
}
