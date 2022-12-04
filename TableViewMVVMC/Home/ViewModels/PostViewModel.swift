//
//  PostViewModel.swift
//  TableViewMVVMC
//
//  Created by Saulo Oliveira on 04/12/22.
//

import Foundation

class PostViewModel {
    
    private let post: Post
    
    var postTitle: String {
        return post.title.uppercased()
    }
    
    init(post: Post) {
        self.post = post
    }
}
