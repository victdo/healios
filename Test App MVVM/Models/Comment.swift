//
//  Comment.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import Foundation
import RealmSwift
import ObjectMapper
import SwiftyJSON

struct Comment: Codable {
    var postId, id: Int
    var name, email, body: String
}

class CommentRealm:  Object {
    @objc dynamic var id = 0
    @objc dynamic var postId = 0
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var body = ""
    
    
    required convenience init(map: Comment) {
        self.init()
        self.id = map.id
        self.postId = map.postId
        self.name = map.name
        self.email = map.email
        self.body = map.body
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
   
    
    
}
