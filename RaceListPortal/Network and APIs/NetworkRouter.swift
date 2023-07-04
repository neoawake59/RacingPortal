//
//  NetworkRouter.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import Foundation
public protocol NetworkRouter {
    associatedtype EndPoint: APIProtocol
    func modelResponseWithRequest<T>(_ route: EndPoint, type: T.Type, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable
    func rawResponseWithRequest(_ route: EndPoint, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> ())
    func cancel()
}
