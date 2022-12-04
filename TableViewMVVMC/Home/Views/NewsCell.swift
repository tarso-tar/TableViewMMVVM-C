//
//  NewsCell.swift
//  TableViewMVVMC
//
//  Created by Saulo Oliveira on 04/12/22.
//

import UIKit

class NewsCell: UITableViewCell {
    
    public static let reuseID = "NewsCell"
 
    let postTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        self.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.postTitle.text = String()
    }
    
    func configure(with viewModel: PostViewModel) {
        self.postTitle.text = viewModel.postTitle
    }
}

extension NewsCell: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(postTitle)
    }
    
    func setupPostTitleConstraints() {
        postTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        postTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        postTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        postTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupConstraints() {
        setupPostTitleConstraints()
    }
}
