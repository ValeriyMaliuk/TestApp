//
//  RepositoryListDataProvider.swift
//  TestApp
//
//  Created by user on 9/20/18.
//  Copyright © 2018 valerii. All rights reserved.
//

protocol RepositoryListDataProvider {
    
    func repositoryListByQuery(_ query: String, success: @escaping ([Repository])->(), failure: @escaping ((Error)->()))
    
}
