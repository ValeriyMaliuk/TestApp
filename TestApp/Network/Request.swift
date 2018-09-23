//
//  Request.swift
//  TestApp
//
//  Created by user on 9/20/18.
//  Copyright © 2018 valerii. All rights reserved.
//
import Alamofire

public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: String]? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
    var baseUrl: String { get }
}
