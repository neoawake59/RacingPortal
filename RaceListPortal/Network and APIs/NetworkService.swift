//
//  NetworkService.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import Foundation
final class NetworkService<EndPoint: APIProtocol>: NetworkRouter {
    
    private let session: URLSession
    private let sessionConfig: URLSessionConfiguration
    
    init(sessionConfig: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.sessionConfig = sessionConfig
        self.session = URLSession(configuration: self.sessionConfig)
    }
    
    func modelResponseWithRequest<T>(_ route: EndPoint, type: T.Type, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable {
        let request = URLRequest(apiProtocol: route)
        print(request,route,type)
        let task = self.session.dataTask(with: request) {[weak self] (data, response, error) in
            print("eror:",error.debugDescription)
            print("response : ",response as Any)
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        }
        task.resume()
    }
    
    func rawResponseWithRequest(_ route: EndPoint, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> ()) {
        let request = URLRequest(apiProtocol: route)
        let task = self.session.dataTask(with: request) {(data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            completion(data,httpResponse,error)
        }
        task.resume()
    }
    
    func cancel() {
        
    }
    
    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (NetworkResponse<T>) -> ()) {
        if let error = error { return completion(.failure(.networkError(error))) }
        guard let response = response else { return completion(.failure(.noResponseData)) }
        switch response.statusCode {
        case 200...299:
            guard let data = data, let model = try? JSONDecoder().decode(T.self, from: data) else { return completion(.failure(.modelDecodeError)) }
            completion(.success(model))
        default:
            completion(.failure(.serverError(response.statusCode)))
        }
    }
}
