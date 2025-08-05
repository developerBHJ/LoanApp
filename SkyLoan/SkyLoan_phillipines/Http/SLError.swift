//
//  SLError.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/19.
//

import Foundation

public enum SLError: Error{
    case failed(error: Error?)
    case tokenExpired(code: Int?)
}

extension SLError{
    public var errorDescription: String? {
        switch self {
        case .failed(let error):
            return ""
        case .tokenExpired(let code):
            return ""
        }
    }
}

