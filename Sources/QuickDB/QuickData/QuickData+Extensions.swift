//
//  QuickData+Extensions.swift
//  QuickDB
//
//  Created by Behrad Kazemi on 4/26/20.
//

import Foundation

public extension QuickDataFile {
	func store(completion: ((Bool) -> Void)? = nil){
		
		QuickDB.shared.insert(model: asRecord(), withTag: Self.makeTags(fileName: fileName, pathExtension: pathExtension)) { (updated) in
			if updated {
				QuickDB.shared.fileManager.save(model: self, completion: completion)
				return
			}
			completion?(false)
		}
	}
}
public extension QuickData {
	func combineFilePath(documentURL: URL) -> URL {
		let file = fileName + uid.uuidString + "." + pathExtension
		let fileURL = documentURL.appendingPathComponent(file)
		return fileURL
	}
	
	func getTags() -> String {
		return Self.makeTags(fileName: fileName, pathExtension: pathExtension)
	}
	
	static func makeTags(fileName: String, pathExtension: String) -> String {
		return "##File#Name#\(fileName).\(pathExtension)##"
	}
}
