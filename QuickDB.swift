//
//  QuickDB.swift
//  QuickDB
//
//  Created by Behrad Kazemi on 4/18/20.
//  Copyright © 2020 BEKSAS. All rights reserved.
//

import Foundation
import CoreData
public final class QuickDB {
	
	public static let shared = QuickDB()
	private(set) lazy var genericDB = GenericDataBase<GenericModel>()
	public func store<T: QuickIndexable>(model: T, completion: ((Bool) -> Void)? = nil) throws {
		
		let genericData = NSEntityDescription.insertNewObject(forEntityName: "GenericModel", into: genericDB.coreDataStack.context) as! GenericModel
		do {
			let objectData  = try JSONEncoder().encode(model)
			genericData.setValue(String(describing: T.self), forKey: "modelName")
			genericData.setValue(model.uid, forKey: "id")
			genericData.setValue(objectData, forKey: "data")
			genericData.setValue("", forKey: "cacheString")
			genericData.setValue(Date(), forKey: "creationDate")
		} catch let error {
			throw error
		}
		genericDB.update(genericData) {[completion] (completed) in
			if completion != nil {
				completion!(completed)
			}
		}
	}
	public func getAll<T: Decodable>(CachesMatchedWithItems caches: [String]? = nil,LatestObjects response: ([T]) -> Void, error: (Error) -> Void) {
		
		let predicate: NSPredicate
		if let safeCaches = caches{
			predicate = NSPredicate(format: "modelName == %@ && ANY cacheString IN %@", String(describing: T.self), safeCaches)
		}else {
			predicate = NSPredicate(format: "modelName == %@", String(describing: T.self))
		}
		let sdSortDate = NSSortDescriptor.init(key: "creationDate", ascending: false)
		genericDB.getAll(predicate: predicate, sortDescriptor: sdSortDate) { [response, error] (result) in
			switch result {
			case .success(let resp):
				response(resp.compactMap {$0.translate()})
			case .failure(let err):
				error(err)
			}
		}
	}
	
	public func delete(ItemIds ids: [String], completion: ((Bool) -> Void)? = nil) {
		let predicate = NSPredicate(format: "ANY id IN %@", ids)
		genericDB.batchDelete(predicate: predicate) { (updated) in
			if completion != nil {
				completion!(updated)
			}
		}
	}
	
	public func removeAll<T: Decodable>(WhereTypeIs type: T.Type, completion: ((Bool) -> Void)? = nil) {
		let predicate = NSPredicate(format: "modelName == %@", String(describing: T.self))
		genericDB.batchDelete(predicate: predicate) { (updated) in
			if completion != nil {
				completion!(updated)
			}
		}
	}
	public func update(cacheString: String, forId id: String, completion: ((Bool) -> Void)? = nil, error: ((Error) -> Void)? = nil) {
		let predicate = NSPredicate(format: "id == %@", id)

		genericDB.getAll(predicate: predicate) {[completion, error, unowned self] (result) in
			switch result {
			case .success(let matchedItems):
				matchedItems.forEach { (matchedItem) in
					matchedItem.cacheString = cacheString
					self.genericDB.update(matchedItem) {[completion] (completed) in
						completion?(completed)
					}
				}
			case .failure(let err):
				error?(err)
			}
		}
	}
	
	public func resetFactory() {
		genericDB.deleteAllRecords()
	}
}
