
//
//  RepositoryListCoordinator.swift
//  TestApp
//
//  Created by user on 9/20/18.
//  Copyright © 2018 valerii. All rights reserved.
//

import UIKit

class RepositoryListCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let dataProvider: RepositoryListDataProvider = GithubAPI()
        let viewModel: RepositoryListViewModel = RepositoryListViewModel(dataProvider)
        
        let storyboard = UIStoryboard(storyboard: .repositoryList)
        let viewController: RepositoryListViewController = storyboard.instantiateViewController()
        
        viewController.setViewModel(viewModel)
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: false)
    }
}
