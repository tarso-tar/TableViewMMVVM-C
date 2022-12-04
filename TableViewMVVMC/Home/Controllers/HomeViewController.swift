//
//  HomeViewController.swift
//  TableViewMVVMC
//
//  Created by Saulo Oliveira on 04/12/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    var homeViewModel: HomeViewModel!
    
    var postViewModels: [PostViewModel] = []
    
    var homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeView.newsTableView.dataSource = self
        self.homeView.newsTableView.delegate = self
        configureViews()
        loadData()
    }
    
    func loadData() {
        homeViewModel.getTopNews { result in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let posts):
                    print("entrando case sucesso")
                    for post in posts {
                        self.postViewModels.append(PostViewModel(post: post))
                    }
                    self.homeView.newsTableView.reloadData()
                    
                case .failure(let error):
                    print("entrando caso de error")
                    self.coordinator?.showPostsAlert(alertTitle:  "Ops, ocorreu um erro", alertMessage: error.localizedDescription, alertActionTitle: "OK")
                    return
                }
                
            }
        }
    }
    
    func configureViews() {
        self.navigationController?.navigationBar.isTranslucent = true
        view.addSubview(homeView)
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsCell.self), for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: postViewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = postViewModels[indexPath.row]
        self.coordinator?.showPostsAlert(alertTitle: "Você tocou em", alertMessage: "\(post.postTitle)", alertActionTitle: "OK")
        
        return
    }
}
