//
//  APIProtocolExtension.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import Foundation
extension APIProtocol {
    var baseURL: URL {
        guard let url = URL(string: "https://api.neds.com.au") else { fatalError("API Base URL Malformed") }
        return url
    }

    
    var apiPath: String {
        return "/rest/v1/racing"
    }
}
