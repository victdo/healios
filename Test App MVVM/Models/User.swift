//
//  User.swift
//  Test App MVVM
//
//  Created by Victor on 01.02.2021.
//

import Foundation
import RealmSwift

struct User: Codable {
    var id: Int
    var name, username, email: String
    var address: Address
    var phone, website: String
    var company: Company
}

struct Address: Codable {
    var street, suite, city, zipcode: String
    var geo: Geo
}

struct Geo: Codable {
    var lat, lng: String
}

struct Company: Codable {
    var name, catchPhrase, bs: String
}

class UserRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var userName = ""
    @objc dynamic var email = ""
    @objc dynamic var phone = ""
    @objc dynamic var website = ""

    @objc dynamic var company: CompanyRealm?
    @objc dynamic var address: AddressRealm?
    
    override class func primaryKey() -> String? {
        return "id"
    }

    convenience init(map: User) {
        self.init()
        self.id = map.id
        self.name = map.name
        self.userName = map.username
        self.email = map.email
        self.phone = map.phone
        self.website = map.website
        self.company = CompanyRealm(map: map.company)
        self.address = AddressRealm(map: map.address)
    }
}

class AddressRealm:  Object {

    @objc dynamic var street = ""
    @objc dynamic var suite = ""
    @objc dynamic var city = ""
    @objc dynamic var zipCode = ""

    @objc dynamic var geo: GeoRealm?


    convenience init?(map: Address) {
        self.init()
        self.street = map.street
        self.suite = map.suite
        self.city = map.city
        self.zipCode = map.zipcode
        
        self.geo = GeoRealm(map: map.geo)
    }

}

class GeoRealm: Object {
    @objc dynamic var lat = ""
    @objc dynamic var lng = ""

    convenience init?(map: Geo) {
        self.init()
        self.lat = map.lat
        self.lng = map.lng
    }
}


class CompanyRealm: Object {
    @objc dynamic var bs = ""
    convenience init(map: Company) {
        self.init()
        self.bs = map.bs
    }

    
}
