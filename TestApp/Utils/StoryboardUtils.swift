//
//  StoryboardUtils.swift
//  TestApp
//
//  Created by user on 9/24/18.
//  Copyright © 2018 valerii. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    @objc public enum Storyboard: Int {
        case repositoryList
        
        var filename: String {
            switch self {
            case .repositoryList:
                return "RepositoryList"
            }
        }
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}

