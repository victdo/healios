//
//  PostViewModel.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import Foundation

import RxSwift
class PostViewModel: ViewModel {
    
    let netSer = NetworkService.sharedService
    let repService = Repository.sharedRepository
    
    let posts: Property<[PostRealm]> = Property([])
    let users: Property<[UserRealm]> = Property([])
    let comments: Property<[CommentRealm]> = Property([])
    
    let userId = Property(0)
    let id = Property(0)
    let postTitle: Property<String> = Property("")
    let postPostBody: Property<String> = Property("")
    
    
    lazy var getPostsCommand: AsyncCommand<[PostRealm]> = AsyncCommand {
        return self.repService.loadPosts().do(onNext: { [unowned self] result in
            self.posts.set(value: result)
        })
    }
    
    lazy var getUsersCommand: AsyncCommand<[UserRealm]> = AsyncCommand {
        return self.repService.loadUsers().do(onNext: { [unowned self] result in
            self.users.set(value: result)
        })
    }
    
    lazy var getCommentsCommand: AsyncCommand<[CommentRealm]> = AsyncCommand {
        return self.repService.loadComments().do(onNext: { [unowned self] result in
            self.comments.set(value: result)
        })
    }
    
    
}
