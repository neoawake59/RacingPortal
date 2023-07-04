//
//  NetworkError.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import Foundation
public enum NetworkError: Error {
    case unknown
    case networkError(_ error: Error)
    case serverError(_ responseCode: Int)
    case noResponseData
    case modelDecodeError
}
