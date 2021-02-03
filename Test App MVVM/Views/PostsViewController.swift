//
//  PostsViewController.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import UIKit
import RxSwift

class PostsViewController : UIViewController, CommentCatcherTableView, PostsCatcherTableView {
    
    let viewModel = PostViewModel()
    @IBOutlet weak var postsTableView: UITableView!
    var postsTableViewDataSource: PostsTableViewDataSource!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getPostsCommand.execute()
        viewModel.getCommentsCommand.execute()
        viewModel.getUsersCommand.execute()
        
        
        self.viewModel.posts.change.subscribe(onNext: { _ in
            self.setupPostTableView()
        }).disposed(by: disposeBag)

    }
    
    func currentSelected(_ indexPath: IndexPath) {
        let controller = PostDetailViewController.instantiate()
        
        let post = viewModel.posts.get[indexPath.row]
        controller.viewModel.currentPostId.set(value: post.id)
    
        let user = viewModel.users.get.first {$0.id ==  post.userId}
        controller.viewModel.user.set(value: user)
    
        let comments = viewModel.posts.get.first {$0.id ==  post.id}
        controller.viewModel.post.set(value: comments)
        
        navigationController?.pushViewController(controller, animated: true)
    }
}


extension PostsViewController {
    func setupPostTableView() {
        postsTableViewDataSource = PostsTableViewDataSource(tableView: postsTableView)
        postsTableViewDataSource.catcherController = self
        postsTableViewDataSource.posts = viewModel.posts.get
        postsTableView.dataSource = postsTableViewDataSource
        postsTableView.delegate = postsTableViewDataSource
        
        postsTableView.register(UINib.init(nibName: String.init(describing: PostCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: PostCell.self))
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 44
        
    }
}
