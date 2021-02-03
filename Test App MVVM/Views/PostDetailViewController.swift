//
//  PostDetailViewController.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import Foundation
import RxSwift

class PostDetailViewController : UIViewController, CommentCatcherTableView {
    func currentSelected(_ indexPath: IndexPath) {
        
    }
    
    let viewModel = PostDetailViewModel()
    var commentTableViewDataSource: CommentTableViewDataSource!
    
    @IBOutlet weak var postTitleLbl: UILabel!
    @IBOutlet weak var postBodyLbl: UILabel!
    @IBOutlet weak var postUser: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTitleLbl.text = viewModel.post.get?.title
        postBodyLbl.text = viewModel.post.get?.body
        postUser.text = "Author:  \(viewModel.user.get?.name ?? "")"   
        
        self.viewModel.comments.change.subscribe { result in
            DispatchQueue.main.async {
                switch result {
                    case .next( _):
                        let res = self.viewModel.repService.getCommentsBy(postId: self.viewModel.currentPostId.get)
                        self.setupCommentsTableView(res)
                    default:
                        break
                }
            }
        }
    }
    
}

extension PostDetailViewController {
    
    func setupCommentsTableView(_ resArray: [CommentRealm]) {
        commentTableViewDataSource = CommentTableViewDataSource(tableView: commentsTableView)
        commentTableViewDataSource.catcherController = self
        commentTableViewDataSource.comments = resArray
        commentsTableView.dataSource = commentTableViewDataSource
        commentsTableView.delegate = commentTableViewDataSource

        commentsTableView.register(UINib.init(nibName: String.init(describing: CommentCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: CommentCell.self))
        commentsTableView.rowHeight = UITableView.automaticDimension
        commentsTableView.estimatedRowHeight = 44
        
    }
}
