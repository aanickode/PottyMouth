//
//  UserInfo.swift
//  Scrumdinger
//
//  Created by Akash Anickode on 9/9/23.
//

import RealmSwift
import Foundation
class UserInfo: Object {
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var userId: String = ""
    @objc dynamic var totalScore: Int = 0
    dynamic var profanitySet: List<String> = List<String>()
    dynamic var freqMap: Map<String, Int> = Map()
}
