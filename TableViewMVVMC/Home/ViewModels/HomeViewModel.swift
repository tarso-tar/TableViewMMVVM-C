//
//  HomeViewModel.swift
//  TableViewMVVMC
//
//  Created by Saulo Oliveira on 04/12/22.
//

import Foundation

class HomeViewModel {
    let service: NewsService
    
    init(service: NewsService = NewsService(urlString: HomeConstants.topNewsURL)) {
        self.service = service
    }
    
    func getTopNews(completion: @escaping (Result<[Post], NewsServiceError>) -> Void)  {
        service.getTopNewsMock { result in
            switch result {
            case .success(let posts):
                print("lista de posts retornados", posts)
                completion(.success(posts))
            case .failure(let error):
                print("ocorreu o seguinte erro", error)
                completion(.failure(error))
            }
        }
    }
}
