//
//  QuickFM.swift
//  QuickDB
//
//  Created by Behrad Kazemi on 4/26/20.
//

import Foundation
public struct QuickFM {
	public static var documentPath: URL? {
		let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
		return documentsPath.appendingPathComponent("QuickDBStorage")
	}
//	let logsPath = QuickDB.documentPath
//	do{
//	try FileManager.default.createDirectory(atPath: logsPath!.path, withIntermediateDirectories: true, attributes: nil)
//	}catch let error{
//	 print("QuickDB > Error: \(error)")
//	}
	public func save(model: QuickData, completion: ((Bool) -> Void)? = nil) {
		
	}
	public func remove(model: QuickData, completion: ((Bool) -> Void)? = nil) {
		
	}
	public func read(model: QuickData, completion: ((Bool) -> Void)? = nil) {
		
	}
	public func resetFactory(){
		
	}
}
