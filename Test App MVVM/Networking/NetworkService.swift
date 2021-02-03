//
//  NetworkService.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import Foundation
//import SwiftyJSON
import RxSwift
import Alamofire

class FDError: Error {
    var code: Int = 0
    var title: String?
    var message: String = ""
    
    convenience init(error: Error) {
        self.init()
        
        let errorObject = error as NSError
        self.code = errorObject.code
        self.title = "error"
        self.message = errorObject.localizedDescription
        
    }
    
    convenience init(code: Int? = 0, title: String? = nil, message: String) {
        self.init()
        
        if let code = code {
            self.code = code
        }
        self.message = message
        
    }
}

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}


class NetworkService {
    static let sharedService = NetworkService()
    
    let postRequest = PostRequest()
    
    
    func checkBackendError(response: DataResponse<Any>?) -> FDError? {
        
        if !Connectivity.isConnectedToInternet() {
            return FDError(code: nil, message: "Enable network to continue using Facedrive application")
        }
        
        switch response?.response?.statusCode {
        case 200:
            return nil
        default:
            return FDError(code: 400, message: "Unknown error. Try again later")
        }
    }
    
    
    func getPostsRequest() ->  Observable<[Post]> {
        return Observable.create { (subscriber) -> Disposable in
            let request = self.postRequest.getPostsRequest().responseJSON { (response) in
                if let error = self.checkBackendError(response: response) {
                    subscriber.onError(error)
                } else {
                    do {
                        let posts = try JSONDecoder().decode([Post].self, from: response.data!)
                        switch response.result {
                           case .success( _):
                                subscriber.onNext(posts)
                                subscriber.onCompleted()
                            case .failure(let error):
                                subscriber.onError(error)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func getUsersRequest() ->  Observable<[User]> {
        return Observable.create { (subscriber) -> Disposable in
            let request = self.postRequest.getUsersRequest().responseJSON { (response) in
                if let error = self.checkBackendError(response: response) {
                    subscriber.onError(error)
                } else {
                    do {
                        let user = try JSONDecoder().decode([User].self, from: response.data!)
                        switch response.result {
                           case .success( _):
                                subscriber.onNext(user)
                                subscriber.onCompleted()
                            case .failure(let error):
                                subscriber.onError(error)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func getCommentsRequest() ->  Observable<[Comment]> {
        return Observable.create { (subscriber) -> Disposable in
            let request = self.postRequest.getCommentsRequest().responseJSON { (response) in
                if let error = self.checkBackendError(response: response) {
                    subscriber.onError(error)
                } else {
                    do {
                        let comment = try JSONDecoder().decode([Comment].self, from: response.data!)
                        switch response.result {
                           case .success( _):
                                subscriber.onNext(comment)
                                subscriber.onCompleted()
                            case .failure(let error):
                                subscriber.onError(error)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}
