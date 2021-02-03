//
//  PostsTableView.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import UIKit

// MARK: -TableViewDelegate
protocol PostsCatcherTableView: class {
    func currentSelected(_ indexPath: IndexPath)
}

// MARK: -TableView DataSource
class PostsTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView: UITableView
    weak var  catcherController: PostsCatcherTableView?
    var posts = [PostRealm]()
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: String.init(describing: PostCell.self)) as! PostCell
        cell.configureWith(value: posts[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        catcherController?.currentSelected(indexPath)
    }
}
