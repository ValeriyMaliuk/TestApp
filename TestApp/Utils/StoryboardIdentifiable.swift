//
//  StoryboardIdentifiable.swift
//  TestApp
//
//  Created by user on 9/24/18.
//  Copyright © 2018 valerii. All rights reserved.
//
import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }
