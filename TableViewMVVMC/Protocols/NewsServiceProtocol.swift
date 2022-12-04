//
//  NewsServiceProtocol.swift
//  TableViewMVVMC
//
//  Created by Saulo Oliveira on 04/12/22.
//

import Foundation

protocol NewsServiceProtocol {
    func getTopNews(completion: @escaping (Result<[Post], NewsServiceError>) -> Void)
}
