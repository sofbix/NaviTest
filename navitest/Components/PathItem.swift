//
//  PathItem.swift
//  navitest
//
//  Created by Sergey Balalaev on 27.05.2023.
//

import Foundation

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
