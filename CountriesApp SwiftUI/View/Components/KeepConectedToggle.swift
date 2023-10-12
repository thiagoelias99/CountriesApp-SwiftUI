//
//  KeepConectedToggle.swift
//  CountriesApp SwiftUI
//
//  Created by user241339 on 10/12/23.
//

import SwiftUI

struct KeepConectedToggle: View {
    @Binding var rememberUser: Bool
    
    var body: some View {
        HStack(alignment: .center){
            Spacer()
            Text("Manter conectado")
                .font(.caption)
            Toggle("", isOn: $rememberUser)

                .frame(width: 50)
        }
    }
}

struct KeepConectedToggle_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            KeepConectedToggle(rememberUser: .constant(false))
            KeepConectedToggle(rememberUser: .constant(true))
        }
    }
}
