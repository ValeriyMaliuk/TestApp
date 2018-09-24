//
//  Coordinator.swift
//  TestApp
//
//  Created by user on 9/20/18.
//  Copyright © 2018 valerii. All rights reserved.
//

import UIKit

protocol Coordinator: class {

    var navigationController: UINavigationController { get set }
    
    func start()
}
