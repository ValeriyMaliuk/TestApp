//
//  ResositoryListResponse.swift
//  TestApp
//
//  Created by user on 9/20/18.
//  Copyright © 2018 valerii. All rights reserved.
//

struct RepositoryListResponse {
    var repositoryList: [Repository]
}

extension RepositoryListResponse : Decodable {
    
    enum CodingKeys: String, CodingKey {
        case repositoryList = "items"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        repositoryList = try values.decode([Repository].self, forKey: .repositoryList)
    }
}
