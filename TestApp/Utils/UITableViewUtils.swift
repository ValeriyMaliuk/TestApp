//
//  UITableViewUtils.swift
//  TestApp
//
//  Created by user on 9/24/18.
//  Copyright © 2018 valerii. All rights reserved.
//
import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: CellViewModel>(withModel model: T, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: T.CellType.self)
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let cell = cell as? T.CellType {
            model.setup(cell: cell)
        } else {
            fatalError("dequeued wrong cell")
        }
        
        return cell
    }
    
    func register<T: CellViewModel>(nibModels: [T.Type]) {
        for model in nibModels {
            let identifier = String(describing: model.CellType.self)
            register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
}
