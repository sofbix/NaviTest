//
//  ContentView.swift
//  navitest
//
//  Created by Dmitriy Soloshenko on 22.10.2022.
//

import SwiftUI

class Coordinator: ObservableObject {
    @Published var path: [String] = []
    
    func resolve(pathItem:String) -> some View {
        Group {
            switch pathItem {
            case "first": FirstView()
            case "second": SecondView()
            case "third": ThirdView()
            case "fourth": FourthView()
            default:
                EmptyView()
            }
        }
    }
}


struct ContentView: View {
    @ObservedObject private var model = Coordinator()
    var body: some View {
   
        NavigationStack(path: $model.path) {
            VStack {
                Text("Navigation stack")
                    .padding()
                
                Button { model.path = ["first"] } label: { ButtonContent("First View") }
                Button { model.path = ["second"] } label: { ButtonContent("Second View") }
                Button { model.path = ["third"] } label: { ButtonContent("Third View") }
                Button { model.path = ["fourth"] } label: { ButtonContent("Fourth View") }
                
                Spacer()
                Button { model.path = ["first", "second", "third", "fourth"] }
                         label: { ButtonContent("The furthest view") }
                Button { model.path = [] } label: { ButtonContent("Root View") }
                Spacer().frame(height: 32)
            }
            .navigationDestination(for: String.self) { destination in
                model.resolve(pathItem: destination)
            }
        }
        .environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func ButtonContent(_ title: String) -> some View {
        Text(title)
            .foregroundColor(.white)
            .padding()
            .background(Color.gray)
    }
}
