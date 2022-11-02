//
//  SecondView.swift
//  navitest
//
//  Created by Dmitriy Soloshenko on 22.10.2022.
//

import SwiftUI

struct SecondView: View {
    @EnvironmentObject private var model: Coordinator
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("SecondView")
            ButtonContent("Third View") { model.path += ["third"] }
            ButtonContent("Root View") { model.path = [] }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.orange)
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
