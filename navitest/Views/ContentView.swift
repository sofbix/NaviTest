//
//  ContentView.swift
//  navitest
//
//  Created by Dmitriy Soloshenko on 22.10.2022.
//

import SwiftUI

indirect enum PathItem : Hashable {
    case first
    case second(number: Int)
    case third(string: String)
    case fourth(nextScreenName: String?, nextScreenPath: PathItem?)

    init?(pathItem: String, fields: [String: String]) {
        switch pathItem {
        case "first"  :
            self = .first
        case "second" :
            self = .second(number: Int(fields["numberParam"] ?? "") ?? 0)
        case "third"  :
            self = .third(string: fields["stringParam"] ?? "")
        case "fourth" :
            var nextScreenPath: PathItem? = nil
            if let fourthNextScreenPath = fields["fourthNextScreenPath"] {
                nextScreenPath = PathItem(pathItem: fourthNextScreenPath, fields: fields)
            }
            self = .fourth(nextScreenName: fields["fourthNextScreenName"], nextScreenPath: nextScreenPath)
        default:
            return nil
        }
    }
}

class Coordinator: ObservableObject {
    @Published var path: [PathItem] = []
    
    func resolve(pathItem: PathItem) -> some View {
        Group {
            switch pathItem {
            case .first: FirstView()
            case .second(let number): SecondView(number: number)
            case .third(let string): ThirdView(string: string)
            case .fourth(let nextScreenName, let nextScreenPath):
                FourthView(nextScreenName: nextScreenName, nextScreenPath: nextScreenPath)
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

                ButtonContent("First View") { model.path = [.first] }
                ButtonContent("Second View") { model.path = [.second(number: 1)] }
                ButtonContent("Third View") { model.path = [.third(string: "Default")] }
                ButtonContent("Fourth View") { model.path = [fourthPathItem] }
                
                Spacer()
                ButtonContent("The furthest view") { model.path = [.first, .second(number: 2), .third(string: "other"), fourthPathItem] }
                ButtonContent("Root View") { model.path = [] }
                Spacer().frame(height: 32)
            }
            .navigationDestination(for: PathItem.self) { destination in
                model.resolve(pathItem: destination)
            }
        }
        .onOpenURL{ url in
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                return
            }

            let pathItems = components.path.split(separator: "/")
            let fields : [String: String] = components.queryItems?.reduce(into:[String: String]()) { result, component in
                if let value = component.value, !value.isEmpty {
                    result[component.name] = value
                }
            } ?? [:]

            var newPath: [PathItem] = []

            for item in pathItems {
                if let pathItem = PathItem(pathItem: String(item), fields: fields) {
                    newPath.append(pathItem)
                }
            }

            model.path += newPath
        }
        .environmentObject(model)
    }

    var fourthPathItem: PathItem {
        return .fourth(nextScreenName: "Default Second", nextScreenPath: .second(number: 3))
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
