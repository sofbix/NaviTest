//
//  FourthView.swift
//  navitest
//
//  Created by Dmitriy Soloshenko on 22.10.2022.
//

import SwiftUI

struct FourthView: View {
    @EnvironmentObject private var model: Coordinator

    let nextScreenName: String?
    let nextScreenPath: PathItem?
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("FourthView")
            if let nextScreenName, let nextScreenPath {
                ButtonContent(nextScreenName) { model.path += [nextScreenPath] }
            }
            ButtonContent("Root View") { model.path = [] }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.purple)
    }
}

struct FourthView_Previews: PreviewProvider {
    static var previews: some View {
        FourthView(nextScreenName: "First", nextScreenPath: .first)
    }
}
