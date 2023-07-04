//
//  URLRequestExtension.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import Foundation
extension URLRequest {

    init(apiProtocol: APIProtocol) {
        let urlComponents = URLComponents(apiProtocol: apiProtocol)
        self.init(url: urlComponents.url!)
        httpMethod = apiProtocol.method.rawValue
        apiProtocol.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        if case let .requestParameters(parameters) = apiProtocol.task, apiProtocol.parametersEncoding == .json {
            httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        } else if case let .requestMultiPart(imageData,name,fileName) = apiProtocol.task, apiProtocol.parametersEncoding == .multiPart {
            let boundary = "====\(Date().timeIntervalSince1970)==="
            addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            var data = Data()
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: \(ImageFormat.get(from: imageData).contentType)\r\n\r\n".data(using: .utf8)!)
            data.append(imageData)
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            httpBody = data
        } else {return}
    }
}
