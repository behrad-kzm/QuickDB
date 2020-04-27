//
//  TestQuickData.swift
//  QuickDB_Tests
//
//  Created by Behrad Kazemi on 4/26/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import UIKit
@testable import QuickDB

class TestQuickData: XCTestCase {
	
	override func setUp() {
		QuickDB.shared.resetFactory()
	}
	
	override func tearDown() {
		QuickDB.shared.resetFactory()
	}
	
	func test_Converting_To_QuickFile() {
		let quickData = UIImage(imageLiteralResourceName: "Image").pngData()?.asQuickFile(fileName: "MyImage")
		
		XCTAssertEqual(quickData?.fileName, "MyImage")
		XCTAssertEqual(quickData?.pathExtension, "png")
		XCTAssertNotNil(quickData?.data)
		
	}
	
	func test_File_Exists_After_Storing() {
		let quickData = UIImage(imageLiteralResourceName: "Image").pngData()?.asQuickFile(fileName: "MyImage")
		quickData?.store()
		if let dir = QuickFM.documentPath, let filePath = quickData?.combineFilePath(documentURL: dir).path {
			let fileExist = FileManager.default.fileExists(atPath: filePath)
			XCTAssert(fileExist)
			return
		}
		XCTAssert(false)
	}
	
	func test_Comparing_Size_Of_QuickDataFile_And_QuickDataRecord() {
		let quickData = UIImage(imageLiteralResourceName: "Image").pngData()?.asQuickFile(fileName: "MyImage")
		
		let quickDataFileConvertedSize  = try! JSONEncoder().encode(quickData).count
		let quickDataRecordConvertedSize = try! JSONEncoder().encode(quickData?.convertToRecord()).count
		
		XCTAssertNotEqual(quickDataFileConvertedSize, quickDataRecordConvertedSize)
	}
	
	func test_File_Has_A_Correct_Record_After_Storing(){
		let quickData = UIImage(imageLiteralResourceName: "Image").pngData()?.asQuickFile(fileName: "MyImage")
		quickData?.store(completion: { (updated) in
			QuickDB.shared.getAll(TagsMatchedWithItems: [quickData?.getTags() ?? ""], LatestObjects: { (items: [QuickDataRecord]) in
						XCTAssert(items.count > 0)
					XCTAssertEqual(items.first?.uid, quickData?.uid)
					XCTAssertEqual(items.first?.fileName, quickData?.fileName)
					XCTAssertNotNil(items.first?.data)
				}) { (error) in
					XCTAssert(false)
				}
		})
	}
	
	func test_Reading_A_Stored_File(){
		let quickData = UIImage(imageLiteralResourceName: "Image").pngData()?.asQuickFile(fileName: "MyImage")
		quickData?.store()
		QuickDB.shared.data(fileName: "MyImage", fileType: .png) { (items) in
			if let safeData = items?.first {
				XCTAssertEqual(safeData, quickData?.data!)
				return
			}
			XCTAssert(false)
		}
	}
	func test_Deleting_A_Stored_File(){
		let quickData = UIImage(imageLiteralResourceName: "Image").pngData()?.asQuickFile(fileName: "MyImage")
		quickData?.store()
		
		QuickDB.shared.delete(fileName: "MyImage", fileType: .png) { (updated) in
			if updated {				
				QuickDB.shared.data(fileName: "MyImage", fileType: .png) { (items) in
					
					XCTAssertNil(items)
				}
			}else{
				XCTAssert(false)
			}
		}
	}
}

extension QuickDataFile {
		func convertToRecord() -> QuickDataRecord{
			return QuickDataRecord(uid: uid, fileName: fileName, pathExtension: pathExtension)
		}
}
