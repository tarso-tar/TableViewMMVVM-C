//
//  NewsService.swift
//  TableViewMVVMC
//
//  Created by Saulo Oliveira on 04/12/22.
//

import Foundation

class NewsService: NewsServiceProtocol {
    private var urlSession: URLSession
    private var urlString: String
    
    
    init(urlString: String, urlSession: URLSession = .shared){
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    public func getTopNews(completion: @escaping (Result<[Post], NewsServiceError>) -> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(NewsServiceError.invalidURL))
        }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(NewsServiceError.failedRequest(description: error.localizedDescription)))
            }
            let decoder = JSONDecoder()
            if let safeData = data {
                do {
                    let results = try decoder.decode(Results.self, from: safeData)
                    return completion(.success(results.hits))
                }
                catch {
                    return completion(.failure(NewsServiceError.failedDecoding))
                }
            }
        }
        
        task.resume()
    }
}


