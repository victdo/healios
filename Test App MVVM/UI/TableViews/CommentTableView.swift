//
//  CommentTableView.swift
//  Test App MVVM
//
//  Created by Victor on 02.02.2021.
//

import UIKit

protocol CommentCatcherTableView: class {
    func currentSelected(_ indexPath: IndexPath)
}

class CommentTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView: UITableView
    weak var catcherController: CommentCatcherTableView?
    var comments = [CommentRealm]()
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: String.init(describing: CommentCell.self)) as! CommentCell
        cell.configureWith(value: comments[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        catcherController?.currentSelected(indexPath)
    }
}
