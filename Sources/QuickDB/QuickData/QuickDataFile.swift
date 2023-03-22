//
//  QuickDataFile.swift
//  QuickDB
//
//  Created by Behrad Kazemi on 4/26/20.
//

import Foundation
public struct QuickDataFile: QuickData {
	public let uid: UUID
	public var fileName: String
	public var pathExtension: String
	public var data: Data?
	
	public init (uid: UUID = UUID(), fileName: String, pathExtension: String, data: Data?){
		self.uid = uid
		self.fileName = fileName
		self.pathExtension = pathExtension
		self.data = data
	}
	func asRecord() -> QuickDataRecord{
		return QuickDataRecord(uid: uid, fileName: fileName, pathExtension: pathExtension)
	}
}
