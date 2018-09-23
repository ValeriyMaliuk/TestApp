//
//  RepositoryTableCellViewModel.swift
//  TestApp
//
//  Created by user on 9/23/18.
//  Copyright © 2018 valerii. All rights reserved.
//
import UIKit

class RepositoryTableCellViewModel {
    
    var name: String
    var language: String
    var description: String
    var ownerImageUrl: String
    
    private var _isPrivate: Bool
    var isPrivate: String {
        return _isPrivate ? "private" : "public"
    }
    
    private var _watchersNumber: Int
    var watchersNumber: String {
        return _watchersNumber < 1000 ? "\(_watchersNumber)" : "\(_watchersNumber / 1000)K"
    }
    
    init(_ repository: Repository) {
        name = repository.name
        language = repository.language ?? ""
        _isPrivate = repository.isPrivate
        description = repository.description
        ownerImageUrl = repository.ownerImageUrl
        _watchersNumber = repository.watchersNumber
    }
}

//MARK: - CellViewModel
extension RepositoryTableCellViewModel : CellViewModel {

    func setup(cell: RepositoryTableCell) {
        cell.setup(viewModel: self)
    }
}
