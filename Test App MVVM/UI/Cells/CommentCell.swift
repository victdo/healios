//
//  CommentCell.swift
//  Test App MVVM
//
//  Created by Victor on 02.02.2021.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
   override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
   }
    
    func configureWith(value: CommentRealm) {
            self.nameLbl.text = value.name
            self.emailLbl.text = "Email: " + value.email
            self.bodyLbl.text = value.body
        
    }
}
