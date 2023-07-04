//
//  URLComponentsExtension.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import Foundation
extension URLComponents {

    init(apiProtocol: APIProtocol) {
        let url = apiProtocol.baseURL.appendingPathComponent(apiProtocol.apiPath).appendingPathComponent(apiProtocol.path)
        self.init(url: url, resolvingAgainstBaseURL: false)!
        guard case let .requestParameters(parameters) = apiProtocol.task, apiProtocol.parametersEncoding == .url else { return }
        queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
