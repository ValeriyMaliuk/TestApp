//
//  ResponseError.swift
//  TestApp
//
//  Created by user on 9/24/18.
//  Copyright © 2018 valerii. All rights reserved.
//
import Foundation

public enum ResponseError: Error {
    
    case unknown
    case noDataInResponse
    case noConnection
}

extension ResponseError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("Unknown error.", comment: " unknown error")
        case .noDataInResponse:
            return NSLocalizedString("Server returned empty response", comment: "")
        case .noConnection:
            return NSLocalizedString("No internet connection", comment: "")
        }
    }
}

