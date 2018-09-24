//
//  ViewController.swift
//  TestApp
//
//  Created by user on 9/19/18.
//  Copyright © 2018 valerii. All rights reserved.
//

import UIKit

class RepositoryListViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private properties
    private var viewModel: RepositoryListViewModel!
    
    //MARK: - Public properties
    weak var coordinator: Coordinator!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(nibModels: [RepositoryTableCellViewModel.self])
        
        bindToViewModel()
        reloadData()
    }
    
    //MARK: - Public methods
    func setViewModel(_ vm: RepositoryListViewModel) {
        viewModel = vm
    }
    
    //MARK: - ViewModel
    private func bindToViewModel() {
        self.viewModel.didUpdate = viewModelDidUpdate
        self.viewModel.didReceiveError = viewModelDidReceiveError
    }
    
    private lazy var viewModelDidUpdate: (RepositoryListViewModel) -> () = { [weak self] _ in
        guard let `self` = self else { return }
        
        self.title = self.viewModel.title
        self.navigationItem.rightBarButtonItem?.isEnabled = !self.viewModel.isUpdating
        self.tableView.reloadData()
    }
    
    private lazy var viewModelDidReceiveError: (Error) -> () = { [weak self] error in
        guard let `self` = self else { return }
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            self.reloadData()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(retryAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func reloadData() {
        viewModel.reloadData()
    }
}

 //MARK: - Actions
private extension RepositoryListViewController {
    
    @IBAction func refreshAction(_ sender: Any) {
        reloadData()
    }
}

//MARK: - UITableViewDataSource
extension RepositoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositoryCellViewModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.repositoryCellViewModelList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withModel: vm, for: indexPath)
        return cell
    }
}
