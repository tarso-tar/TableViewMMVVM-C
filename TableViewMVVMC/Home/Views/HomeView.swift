//
//  HomeView.swift
//  TableViewMVVMC
//
//  Created by Saulo Oliveira on 04/12/22.
//

import UIKit

class HomeView: UIView {
    
    // MARK: SubViews
    private let WelcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, Welcome to top news, stay tunned with informattion about the world"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let newsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.rowHeight = 120
        table.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
        return table
    }()
    
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .gray
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: ViewCode
extension HomeView: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(newsTableView)
    }
    
    func setupWelcomeLabelConstraints() {
        self.WelcomeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.WelcomeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.WelcomeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }
    
    func setupNewsTableViewConstraints() {
        newsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        newsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        newsTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    func setupConstraints() {
        setupNewsTableViewConstraints()
        self.bottomAnchor.constraint(equalTo: newsTableView.bottomAnchor, constant: -8).isActive = true
    }
}
