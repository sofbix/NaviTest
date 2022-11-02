//
//  FourthView.swift
//  navitest
//
//  Created by Dmitriy Soloshenko on 22.10.2022.
//

import SwiftUI

struct FourthView: View {
    @EnvironmentObject private var model: Coordinator
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("FourthView")
            ButtonContent("Second View") { model.path += ["second"] }
            ButtonContent("Root View") { model.path = [] }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.purple)
    }
}

struct FourthView_Previews: PreviewProvider {
    static var previews: some View {
        FourthView()
    }
}
