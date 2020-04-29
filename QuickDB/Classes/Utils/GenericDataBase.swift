//
//  CoreDataManager.swift
//  CoreDataManager
//
//  Created by Salar Soleimani on 2020-03-06.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import CoreData

struct GenericDataBase<T: NSManagedObject> {
  
  let coreDataStack = CoreDataStack()
  func deleteAllRecords() {
    let entityName = String(describing: T.self)
    let coord = coreDataStack.context.persistentStoreCoordinator
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    do {
      try coord?.execute(deleteRequest, with: coreDataStack.context)
    } catch let error as NSError {
      debugPrint(error)
    }
  }
  var items = [T]()
  
  init() {
    self.init(items: [T]())
    SJParentValueTransformer<Int16s>.registerTransformer()
    getAll(predicate: nil) { _ in }
  }
  
  init(items: [T]) {
    self.items = items
  }
  
  private func save(duty: CoreDataError, completion: (Result<Bool, CoreDataError>)->()) {
    do {
      try coreDataStack.context.save()
      completion(.success(true))
    } catch let err {
      completion(.failure(duty))
      print("Failed to store data into CoreData: \(err)")
    }
  }
  
  func getAll(predicate: NSPredicate?, sortDescriptor: NSSortDescriptor? = nil, pageIndex: Int? = nil, eachPage: Int? = nil, completion: (Result<[T], CoreDataError>)->()) {
    let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
    if let pageIndex = pageIndex, let eachPage = eachPage, pageIndex >= 1 {
      fetchRequest.fetchOffset = pageIndex
      fetchRequest.fetchLimit = eachPage
    }
    fetchRequest.predicate = predicate
    
    if let sort = sortDescriptor {
      fetchRequest.sortDescriptors = [sort]
    }
    
    do {
      let list = try coreDataStack.context.fetch(fetchRequest)
      if list.isEmpty {
        completion(.failure(.isEmpty))
      } else {
        completion(.success(list))
      }
    } catch let err {
      print("error on getting items from DB: \(err)")
      completion(.failure(.getError))
    }
  }
  func batchDelete(predicate: NSPredicate?, completion: (Bool)->()) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
    
    fetchRequest.predicate = predicate
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    do {
      try coreDataStack.context.execute(deleteRequest)
      completion(true)
    } catch let error {
      print("error on batch deleting items with error: \(error)")
      completion(false)
    }
  }
  
  @available(iOS 13.0, *)
  func batchInsert(object: [[String : Any]], completion: (Bool)->()) {
    let insertRequest = NSBatchInsertRequest(entityName: String(describing: T.self), objects: object)
    do {
      try coreDataStack.context.execute(insertRequest)
      completion(true)
    } catch let error {
      print("error on batch inserting items with error: \(error)")
      completion(false)
    }
  }
  
  mutating func delete(_ item: T, completion: (Bool)->()) {
    if let index = items.firstIndex(of: item) {
      items.remove(at: index)
    }
    
    coreDataStack.context.delete(item)
    save(duty: .deleteError) { (result) in
      switch result {
      case .success(_):
        completion(true)
      case .failure(_):
        completion(false)
      }
    }
  }
  mutating func add(_ item: T, completion: (Bool)->()) {
    if (items.contains(item)) {
      items.append(item)
    }
    
    save(duty: .addError) { (result) in
      switch result {
      case .success(_):
        completion(true)
      case .failure(_):
        completion(false)
      }
    }
  }
  mutating func update(_ item: T, completion: (Bool)->()) {
    if (items.contains(item)) {
      items.append(item)
    }
    
    save(duty: .updateError) { (result) in
      switch result {
      case .success(_):
        completion(true)
      case .failure(_):
        completion(false)
      }
    }
  }
}


