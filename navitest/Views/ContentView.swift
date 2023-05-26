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
    @StateObject private var model = Coordinator()
    var body: some View {
   
        NavigationStack(path: $model.path) {
            VStack {
                Text("Navigation stack")
                    .padding()
                
                ButtonContent("First View") { model.path = ["first"] }
                ButtonContent("Second View") { model.path = ["second"] }
                ButtonContent("Third View") { model.path = ["third"] }
                ButtonContent("Fourth View") { model.path = ["fourth"] }
                
                Spacer()
                ButtonContent("The furthest view") { model.path = ["first", "second", "third", "fourth"] }
                ButtonContent("Root View") { model.path = [] }
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
    func ButtonContent(_ title: String, action:(()->Void)?) -> some View {
        Button {
            action?()
        } label: {
            Text(title)
                .foregroundColor(.white)
                .padding()
        }
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
