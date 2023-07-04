//
//  APIProtocol.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import Foundation
public typealias HTTPHeaders = [String:String]
public typealias Parameters = [String:Any]

public protocol APIProtocol {
    var baseURL: URL {get}
    var apiPath: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var task: HTTPTask {get}
    var headers: HTTPHeaders? {get}
    var parametersEncoding: ParametersEncoding {get}
}
