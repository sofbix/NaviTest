//
//  FirstView.swift
//  navitest
//
//  Created by Dmitriy Soloshenko on 22.10.2022.
//

import SwiftUI

struct FirstView: View {
    @EnvironmentObject private var model: Coordinator
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("FirstView")
            ButtonContent("Second View") { model.path += ["second"] }
            ButtonContent("Root View") { model.path = [] }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
