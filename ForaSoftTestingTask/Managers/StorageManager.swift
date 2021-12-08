//
//  StorageManager.swift
//  ForaSoftTestingTask
//
//  Created by Максим Изварин on 08.12.2021.
//

import RealmSwift

class StorageManager {
    //MARK: - Static properties
    static let shared = StorageManager()
    
    //MARK: - Public functions
    func saveEntity<T: Object>(_ entity: T) {
        DispatchQueue.global().sync {
            let realm = try! Realm()
            do {
                try realm.write {
                    realm.add(entity, update: .modified)
                }
            } catch let error as NSError {
                print("Something went wrong: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchObjects<T: Object>(type: T.Type, completion: @escaping(([T]) -> Void)) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            let objects = realm.objects(T.self)
            let result = Array(objects)
            completion(result)
        }
    }
    
    //MARK: - Init
    private init() {}
}
