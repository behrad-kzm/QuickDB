//
//  QuickDataRecord.swift
//  Pods-QuickDB_Example
//
//  Created by Behrad Kazemi on 4/26/20.
//

import Foundation

public struct QuickDataRecord: QuickData {
	public let uid: UUID
	public var fileName: String
	public var pathExtension: String
	public var data: Data? {
		if let dir = QuickDB.documentPath{
			let fileURL = combineFilePath(documentURL: dir)
			do {
				return try Data(contentsOf: fileURL)
			} catch let error{
				print("QuickDB > QuickData > Error: \(error)")
			}
		}
		return nil
	}
	
	public init (uid: UUID = UUID(), fileName: String, pathExtension: String){
		self.uid = uid
		self.fileName = fileName
		self.pathExtension = pathExtension
	}
}
