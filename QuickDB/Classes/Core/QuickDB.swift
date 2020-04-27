//
//  QuickDB.swift
//  QuickDB
//
//  Created by Behrad Kazemi on 4/18/20.
//  Copyright © 2020 BEKSAS. All rights reserved.
//

import Foundation
import FileProvider
import CoreData
public final class QuickDB {
	
	public static let shared = QuickDB()
	public let fileManager = QuickFM()
	
	public static var documentPath: URL? {
		return QuickFM.documentPath
	}
	
	private(set) lazy var genericDB = GenericDataBase<GenericModel>()
	public func insert<T: QuickIndexable>(model: T, withTag tag: String = "", completion: ((Bool) -> Void)? = nil) {
		
		let genericData = NSEntityDescription.insertNewObject(forEntityName: "GenericModel", into: genericDB.coreDataStack.context) as! GenericModel

			let objectData  = try! JSONEncoder().encode(model)
			genericData.setValue(String(describing: T.self), forKey: "modelName")
			genericData.setValue(model.uid, forKey: "id")
			genericData.setValue(objectData, forKey: "data")
			genericData.setValue(tag, forKey: "tags")
			genericData.setValue(Date(), forKey: "creationDate")
		genericDB.update(genericData) {[completion] (completed) in
			if completion != nil {
				completion!(completed)
			}
		}
	}
	
	public func update<T: QuickIndexable>(model: T, completion: ((Bool) -> Void)? = nil, error: (Error) -> Void) {
		let predicate = NSPredicate(format: "id == %@", model.uid as CVarArg)
		
		genericDB.getAll(predicate: predicate) { [unowned self](result) in
			switch result {
			case .success(let resp):
				if let safeItem = resp.first {
					let objectData  = try! JSONEncoder().encode(model)
					safeItem.setValue(objectData, forKey: "data")
					self.genericDB.update(safeItem) { (updated) in
						completion?(updated)
					}
					return
				}
				error(CoreDataError.isEmpty)
			case .failure(let err):
				error(err)
			}
		}
	}
	
	public func getAll<T: Decodable>(TagsMatchedWithItems tags: [String]? = nil,LatestObjects response: ([T]) -> Void, error: (Error) -> Void) {
		
		let predicate: NSPredicate
		if let safeTags = tags{
			predicate = NSPredicate(format: "modelName == %@ && ANY tags IN %@", String(describing: T.self), safeTags)
		} else {
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
	
	public func data(fileName: String, fileType: FileType, response: ([Data]?) -> Void){
		getAll(TagsMatchedWithItems: [QuickDataRecord.makeTags(fileName: fileName, pathExtension: fileType.asMimeType())], LatestObjects: { (items: [QuickDataRecord]) in
			let datas = items.compactMap{$0.data}
			response(datas)
		}) { (error) in
			response(nil)
		}
	}
	
	public func get<T: Decodable>(ItemWithId itemId: UUID, response: (T) -> Void, error: (Error) -> Void) {
		let predicate = NSPredicate(format: "id == %@", itemId as CVarArg)
		
		genericDB.getAll(predicate: predicate) { [response, error] (result) in
			switch result {
			case .success(let resp):
				if let safeItem: T = resp.compactMap({ (res) -> T? in
					res.translate()
				}).first {
					response(safeItem)
					return
				}
				error(CoreDataError.isEmpty)
			case .failure(let err):
				error(err)
			}
		}
	}
	
	public func delete(ItemIds ids: [UUID], completion: ((Bool) -> Void)? = nil) {
		let predicate = NSPredicate(format: "ANY id IN %@", ids)
		genericDB.batchDelete(predicate: predicate) { (updated) in
			if completion != nil {
				completion!(updated)
			}
		}
	}

	public func delete(fileName: String, fileType: FileType, completion: ((Bool) -> Void)? = nil) {
		getAll(TagsMatchedWithItems: [QuickDataRecord.makeTags(fileName: fileName, pathExtension: fileType.asMimeType())], LatestObjects: { [delete](items: [QuickDataRecord]) in
			let ids = items.compactMap{$0.uid}
			delete(ids,completion)
		}) { (error) in
			completion?(false)
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
	public func update(tags: String, forId id: UUID, completion: ((Bool) -> Void)? = nil, error: ((Error) -> Void)? = nil) {
		let predicate = NSPredicate(format: "id == %@", id as CVarArg)
		
		genericDB.getAll(predicate: predicate) {[completion, error, unowned self] (result) in
			switch result {
			case .success(let matchedItems):
				matchedItems.forEach { (matchedItem) in
					matchedItem.tags = tags
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
		fileManager.resetFactory()
		genericDB.deleteAllRecords()
	}
}
