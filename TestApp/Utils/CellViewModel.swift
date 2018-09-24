//
//  CellViewModel.swift
//  TestApp
//
//  Created by user on 9/24/18.
//  Copyright © 2018 valerii. All rights reserved.
//
import UIKit

protocol CellViewModel {
    
    associatedtype CellType: UITableViewCell
    func setup(cell: CellType)
}
