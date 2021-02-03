//
//  PostRequest.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import Alamofire

public class PostRequest {
    let baseUrl = "http://jsonplaceholder.typicode.com"
    func getPostsRequest() -> DataRequest {
        return Alamofire.request(baseUrl + "/posts", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
    }
    
    func getUsersRequest() -> DataRequest {
        return Alamofire.request(baseUrl + "/users", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
    }
    
    func getCommentsRequest() -> DataRequest {
        return Alamofire.request(baseUrl + "/comments", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
    }
}
