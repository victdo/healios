//
//  PostCell.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
   override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
   }
    
    func configureWith(value: PostRealm) {
        titleLbl.text = value.title
        bodyTextView.text = value.body
    }
}
