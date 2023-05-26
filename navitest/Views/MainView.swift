//
//  MainView.swift
//  navitest
//
//  Created by Sergey Balalaev on 27.05.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var model = Coordinator()
    var body: some View {

        NavigationStack(path: $model.path) {
            VStack {
                Text("Navigation stack")
                    .padding()

                ButtonContent("First View") {
                    model.path = [.first]
                }
                ButtonContent("Second View") {
                    model.path = [.second(number: 1)]
                }
                ButtonContent("Third View") {
                    model.path = [.third(string: "Default")]
                }
                ButtonContent("Fourth View") {
                    model.path = [fourthPathItem]
                }

                Spacer()

                ButtonContent("The furthest view") {
                    model.path = [.first, .second(number: 2), .third(string: "other"), fourthPathItem]
                }
                ButtonContent("Root View") {
                    model.path = []
                }
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
            model.path += extractNewPath(from: components)
        }
        .environmentObject(model)
    }

    var fourthPathItem: PathItem {
        return .fourth(nextScreenName: "Default Second", nextScreenPath: .second(number: 3))
    }

    func extractNewPath(from components: URLComponents) -> [PathItem] {
        let pathItems = components.path.split(separator: "/")
        let fields : [String: String] = components.queryItems?.reduce(into:[String: String]()) { result, component in
            if let value = component.value, !value.isEmpty {
                result[component.name] = value
            }
        } ?? [:]

        return pathItems.compactMap{ item in
            PathItem(pathItem: String(item), fields: fields)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
