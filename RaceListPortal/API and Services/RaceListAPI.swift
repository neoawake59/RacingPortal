//
//  RaceListAPI.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import Foundation

enum RaceListAPI{
    case getRaceList
}
extension RaceListAPI:APIProtocol{
    var path: String {
        
        switch self {
        case .getRaceList:
            return "/"

        }
        
    }
    
    var method: HTTPMethod {
       return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getRaceList:
            let param:Parameters = ["method":"nextraces","count":10]
            return .requestParameters(param)
        }
        
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
    
    
}
