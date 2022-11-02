//
//  ThirdView.swift
//  navitest
//
//  Created by Dmitriy Soloshenko on 22.10.2022.
//

import SwiftUI

struct ThirdView: View {
    @EnvironmentObject private var model: Coordinator
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("ThirdView")
            ButtonContent("Fourth View") { model.path += ["fourth"] }
            ButtonContent("Root View") { model.path = [] }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
