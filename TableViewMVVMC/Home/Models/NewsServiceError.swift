//
//  NewsServiceError.swift
//  TableViewMVVMC
//
//  Created by Saulo Oliveira on 04/12/22.
//

import Foundation

enum NewsServiceError: Equatable {
    case invalidURL
    case failedDecoding
    case failedRequest(description:String)
}

extension NewsServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .failedDecoding:
            return "Failied while decoding data"
        case .failedRequest(let description):
            return description
        }
    }
}

