//
//  QuickData+Extensions.swift
//  QuickDB
//
//  Created by Behrad Kazemi on 4/26/20.
//

import Foundation

public extension QuickDataFile {
	func store(completion: ((Bool) -> Void)? = nil){
		QuickDB.shared.insert(model: self, withTag: makeTags())
		QuickDB.shared.fileManager.save(model: self, completion: completion)
	}
	func makeTags() -> String {
		return "##File##\(fileName)"
	}
}
