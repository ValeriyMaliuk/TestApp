//
//  RepositoryListViewModel.swift
//  TestApp
//
//  Created by user on 9/20/18.
//  Copyright © 2018 valerii. All rights reserved.
//

class RepositoryListViewModel {
    
    //MARK: - Private properties
    private var dataProvider: RepositoryListDataProvider
    
    //MARK: - Public properties
    var didError: ((Error) -> ())?
    var didUpdate: ((RepositoryListViewModel) -> ())?
    
    private(set) var repositoryCellViewModelList: [RepositoryTableCellViewModel] = []
    
    var title: String {
        if (self.isUpdating) {
            return "Refreshing..."
        } else {
            return "Results"
        }
    }
    
    private(set) var isUpdating: Bool = false {
        didSet { self.didUpdate?(self) }
    }
    
    //MARK: - Init
    init(_ provider: RepositoryListDataProvider) {
        dataProvider = provider
    }
    
    //MARK: - Public methods
    func reloadData() {
        isUpdating = true
        
        dataProvider.repositoryListByQuery("Swift",
            success: { [weak self] repoList in
                guard let `self` = self else { return }
                
                self.repositoryCellViewModelList = repoList.map{ RepositoryTableCellViewModel($0) }
                
                self.isUpdating = false
            },
            failure: {  [weak self] (error) in
                guard let `self` = self else { return }
                
                self.didError?(error)
                self.isUpdating = false
            }
        )
    }
}
