//
//  Post.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import Foundation
import RealmSwift

struct Post: Codable {
    var userId, id: Int
    var title, body: String
}


class PostRealm:  Object {
    @objc dynamic var userId = 0
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var body = ""
    
    required convenience init(map: Post) {
        self.init()
        self.userId = map.userId
        self.id = map.id
        self.title = map.title
        self.body = map.body
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }

}
