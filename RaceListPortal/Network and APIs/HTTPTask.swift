//
//  HTTPTask.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import Foundation
public enum HTTPTask {
    case requestPlain
    case requestParameters(_ parameters: Parameters)
    case requestMultiPart(data: Data, name: String, fileName: String)
}
