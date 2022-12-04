//
//  MainCoordinator.swift
//  TableViewMVVMC
//
//  Created by Saulo Oliveira on 04/12/22.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController()
        let service = NewsService(urlString: HomeConstants.topNewsURL)
        viewController.homeViewModel = HomeViewModel(service: service)
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showPostsAlert(alertTitle: String, alertMessage: String, alertActionTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: nil))
        self.navigationController.present(alert, animated: true, completion: nil)
    }
}
