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
            Button { model.path = ["third"] } label: { ButtonContent("Third View") }
            Button { model.path = [] } label: { ButtonContent("Root View") }
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
