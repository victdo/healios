//
//  PostDetailViewModel.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import Foundation
import RxSwift
class PostDetailViewModel: ViewModel {
    
    let emailProperty:Property<String> = Property("")
    let titleProperty:Property<String> = Property("")
    let bodyProperty:Property<String> = Property("")
    let userProperty:Property<String> = Property("")
    
    let repService = Repository.sharedRepository
    
    let user: Property<UserRealm?> = Property(nil)
    let post: Property<PostRealm?> = Property(nil)
    let comments: Property<[CommentRealm]> = Property([])
    
    let currentPostId: Property<Int> = Property(0)
    
}
