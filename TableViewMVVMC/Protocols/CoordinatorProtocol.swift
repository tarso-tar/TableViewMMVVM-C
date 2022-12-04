//
//  CoordinatorProtocol.swift
//  TableViewMVVMC
//
//  Created by Saulo Oliveira on 04/12/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController  {get set}
    var childCoordinators: [Coordinator] {get set}
    
    func start()
}
