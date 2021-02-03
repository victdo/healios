//
//  Repository.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import RxSwift
import RealmSwift
import ObjectMapper
import SwiftyJSON

let kSLRepositoryName: String = "postApp.realm"

class Repository {
    
    static let sharedRepository = Repository()
    
    let netSer = NetworkService.sharedService
    
    let currentUserID: Property<Int> = Property(0)
    
    init() {
        self.configurateRealmDataBase()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func configurateRealmDataBase() {
        var config = Realm.Configuration()
        config.schemaVersion = 1
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent(kSLRepositoryName)
        config.migrationBlock = { migration, oldSchemaVersion in
        }
        Realm.Configuration.defaultConfiguration = config
    }
    
    //MARK:- Post
    func loadPosts() -> Observable<[PostRealm]> {
        return self.netSer.getPostsRequest().flatMap { posts -> Observable<[PostRealm]> in
            self.savePosts(data: posts)
            return Observable.just(self.getPosts())
        }
    }
    
    func savePosts(data: [Post]) {
        let realm = try! Realm()
        let posts = data
        try! realm.write({
            for post in posts {
                let rlPost = PostRealm(map: post)
                realm.create(PostRealm.self, value: rlPost , update: .all)
            }
        })
    }
    
    func getPosts() -> [PostRealm] {
        let result = try! Realm().objects(PostRealm.self).toArray(type: PostRealm.self)
        guard result.count > 0 else { return [] }
        return result
    }
    
    //MARK:- User
    func loadUsers() -> Observable<[UserRealm]> {
        return self.netSer.getUsersRequest().flatMap { users -> Observable<[UserRealm]>  in
            self.saveUsers(data: users)
            return Observable.just(self.getUsers())
        }
    }
    
    func saveUsers(data: [User]) {
        let realm = try! Realm()
        let users = data
        try! realm.write ({
            for user in users {
                let rlUser = UserRealm(map: user)
                realm.create(UserRealm.self, value: rlUser, update: .all)
            }
        })
    }
    
    func getUsers() -> [UserRealm] {
        let result = try! Realm().objects(UserRealm.self).toArray(type: UserRealm.self)
        guard result.count > 0  else { return [] }
        return result
    }
    
    func getUsersBy(id: Int) -> Results<UserRealm>? {
        let result = try! Realm().objects(UserRealm.self).filter("id == %d", id)
        guard result.count > 0  else { return nil }
        return result
    }
    
    
    
    //MARK:- Comment
    func loadComments() -> Observable<[CommentRealm]> {
        return self.netSer.getCommentsRequest().flatMap { comments -> Observable<[CommentRealm]>  in
            self.saveComment(data: comments)
            return Observable.just(self.getComments())
        }
    }
    
    func loadCommentsBy(postId: Int) -> Observable<[CommentRealm]> {
        return Observable.just(self.getCommentsBy(postId: postId))
    }
    
    func saveComment(data: [Comment]) {
        let realm = try! Realm()
        let comments = data
        try! realm.write ({
            for comment in comments {
                let rlComment = CommentRealm(map: comment)
                realm.create(CommentRealm.self, value: rlComment, update: .all)
            }
        })
    }
    
    func getComments() -> [CommentRealm] {
        let result = try! Realm().objects(CommentRealm.self).toArray(type: CommentRealm.self)
        guard result.count > 0  else { return [] }
        return result
    }
    
    func getCommentsBy(postId: Int) -> [CommentRealm] {
        let result = try! Realm().objects(CommentRealm.self).filter("postId == %d", postId).toArray(type: CommentRealm.self)
        guard result.count > 0  else { return [] }
        return result
    }
}


extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
