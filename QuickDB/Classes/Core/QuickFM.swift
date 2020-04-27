//
//  QuickFM.swift
//  QuickDB
//
//  Created by Behrad Kazemi on 4/26/20.
//

import Foundation
public struct QuickFM {
	
	init() {
		QuickFM.createDirectory()
	}
	public static var documentPath: URL? {
		let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
		return documentsPath.appendingPathComponent("QuickDBStorage")
	}
	
	public func save(model: QuickDataFile, completion: ((Bool) -> Void)? = nil) {
		if let dir = QuickFM.documentPath{
			let fileURL = model.combineFilePath(documentURL: dir)
			do{
				try model.data?.write(to: fileURL)
				completion?(true)
			}catch{
				completion?(false)
			}
		}
	}
	
	public func remove(model: QuickDataRecord, completion: ((Bool) -> Void)? = nil) {
		
		if let dir = QuickFM.documentPath, FileManager.default.fileExists(atPath: model.combineFilePath(documentURL: dir).path){
			let removeFile = model.combineFilePath(documentURL: dir)
			do{
				try FileManager.default.removeItem(at: removeFile)
				completion?(true)
				return
			}catch{
				completion?(false)
				return
			}
		}
		completion?(false)
	}
	
	public func read(model: QuickDataRecord, completion: ((Bool) -> Void)? = nil) {
		
	}
	
	static func createDirectory(){
		let logsPath = QuickFM.documentPath
		do{
		try FileManager.default.createDirectory(atPath: logsPath!.path, withIntermediateDirectories: true, attributes: nil)
		}catch let error{
				print("QuickFM > CreateFolder > Error: \(error)")
		}
	}
	
	public func resetFactory(){
		guard let url = QuickFM.documentPath else {
			return
		}
		
		try! FileManager.default.removeItem(atPath: url.path)
		QuickFM.createDirectory()
	}
}
