//
//  Coordinator.swift
//  navitest
//
//  Created by Sergey Balalaev on 27.05.2023.
//

import SwiftUI

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
