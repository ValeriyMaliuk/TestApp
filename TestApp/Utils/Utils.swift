//
//  Utils.swift
//  TestApp
//
//  Created by user on 9/19/18.
//  Copyright © 2018 valerii. All rights reserved.
//
import Foundation
import Alamofire

extension JSONDecoder {
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }
        
        guard let responseData = response.data else {
            print("didn't get any data from API")
            return .failure(ResponseError.noDataInResponse)
        }
        
        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            print("error trying to decode response")
            print(error)
            return .failure(error)
        }
    }
}

//MARK: - Utils for UIStoryboard
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


//MARK: - Utils for UIViewController

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }


//MARK: - Utils for UITableViewController

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

//MARK: - CellViewModel

protocol CellViewModel {
    associatedtype CellType: UITableViewCell
    func setup(cell: CellType)
}
