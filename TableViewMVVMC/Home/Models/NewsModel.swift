//
//  NewsModel.swift
//  TableViewMVVMC
//
//  Created by Saulo Oliveira on 04/12/22.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable {
    let title: String
    let url: String
}
