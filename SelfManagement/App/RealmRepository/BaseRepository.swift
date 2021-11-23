//
//  BaseRepository.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/22.
//

import RealmSwift

public class BaseRepository {
    var realm: Realm { try! Realm() }
}
