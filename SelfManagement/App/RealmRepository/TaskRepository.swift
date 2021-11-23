//
//  TaskRepository.swift
//  SelfManagement
//
//  Created by hosakaren on 2021/11/22.
//

import RealmSwift

class TaskScheme: Object {
    /// primary key
    @objc dynamic var id: String = NSUUID().uuidString
    /// タスク内容
    @objc dynamic var content: String!
    /// 期日
    @objc dynamic var targetDate: Date!
    /// true: 完了、false: 未完了
    @objc dynamic var isFinished: Bool = false
    @objc dynamic var createdAt: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class TaskRepository: BaseRepository {
        
    func save(_ task: TaskScheme) {
        try! realm.write {
            realm.add(task)
        }
    }
    
    func findOne(_ id: String) -> TaskScheme? {
        realm.object(ofType: TaskScheme.self, forPrimaryKey: id)
    }
    
    func findByIsFinished(_ isFinished: Bool) -> [TaskScheme]? {
        let results = realm.objects(TaskScheme.self).filter("isFinished == %@", isFinished)
        return Array(results)
    }
}
