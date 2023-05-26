//
//  ButtonContent.swift
//  navitest
//
//  Created by Sergey Balalaev on 27.05.2023.
//

import SwiftUI

struct ButtonContent: View {

    private let title: String
    private let action: (()->Void)

    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundColor(.white)
                .padding()
        }
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
