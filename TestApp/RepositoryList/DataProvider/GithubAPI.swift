//
//  GithubAPI.swift
//  TestApp
//
//  Created by user on 9/19/18.
//  Copyright © 2018 valerii. All rights reserved.
//
import  Alamofire

final class GithubAPI : RepositoryListDataProvider {
    
    private enum GithubRequest: Request {
        
        case repositoryListByQuery(_ query: String)
        
        var path: String {
            switch self {
            case .repositoryListByQuery:
                return baseUrl + "/search/repositories"
            }
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var parameters: [String: String]? {
            switch self {
            case .repositoryListByQuery(let query):
                return ["q" : query]
            }
        }
        
        var encoding: ParameterEncoding {
            switch self {
            case .repositoryListByQuery:
                return URLEncoding.queryString
            }
        }
        
        var headers: HTTPHeaders? {
            return nil
        }
        
        var baseUrl: String {
            return "https://api.github.com"
        }
        
    }

    func repositoryListByQuery(_ query: String, success: @escaping ([Repository])->(), failure: @escaping ((Error)->())) {
        
        let request = GithubRequest.repositoryListByQuery(query)
        
        Alamofire.request(request.path, method: request.method, parameters: request.parameters, encoding: request.encoding, headers: request.headers).responseData{ response in
            
            let decoder = JSONDecoder()
            let result: Result<RepositoryListResponse> = decoder.decodeResponse(from: response)
            
            switch result {
            case .success(let response):
                success(response.repositoryList)
            case .failure(let error):
                failure(error)
            }
        }
    }

}
