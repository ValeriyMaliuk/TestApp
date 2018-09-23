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
    public weak var coordinator: Coordinator!
    
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
}

//MARK: - ViewModel
private extension RepositoryListViewController {
    
    private func bindToViewModel() {
        self.viewModel.didUpdate = viewModelDidUpdate
        self.viewModel.didError = viewModelDidError
    }
    
    private func viewModelDidUpdate(viewModel: RepositoryListViewModel) {
        title = self.viewModel.title
        navigationItem.rightBarButtonItem?.isEnabled = !self.viewModel.isUpdating
        tableView.reloadData()
    }
    
    private func viewModelDidError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.reloadData()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(retryAction)
        
        present(alert, animated: true, completion: nil)
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
