//
//  NetworkResponse.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import Foundation
public enum NetworkResponse<T> {
  case success(T)
  case failure(NetworkError)
}
