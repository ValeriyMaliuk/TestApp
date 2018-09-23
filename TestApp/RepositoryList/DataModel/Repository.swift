//
//  Repository.swift
//  TestApp
//
//  Created by user on 9/19/18.
//  Copyright © 2018 valerii. All rights reserved.
//

struct Repository {
    var name: String
    var language: String?
    var isPrivate: Bool
    var description: String
    var ownerImageUrl: String
    var watchersNumber: Int
}

extension Repository : Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name = "full_name"
        case owner = "owner"
        case language = "language"
        case isPrivate = "private"
        case description = "description"
        case watchersNumber = "watchers"
    }
    
    enum OwnerKeys: String, CodingKey {
        case ownerImageUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        isPrivate = try values.decode(Bool.self, forKey: .isPrivate)
        description = try values.decode(String.self, forKey: .description)
        watchersNumber = try values.decode(Int.self, forKey: .watchersNumber)
        
        let owner = try values.nestedContainer(keyedBy: OwnerKeys.self, forKey: .owner)
        ownerImageUrl = try owner.decode(String.self, forKey: .ownerImageUrl)
    }
}
