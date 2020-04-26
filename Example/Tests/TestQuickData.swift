//
//  TestQuickData.swift
//  QuickDB_Tests
//
//  Created by Behrad Kazemi on 4/26/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import UIKit
import QuickDB

class TestQuickData: XCTestCase {
	
	override func setUp() {
		QuickDB.shared.resetFactory()
	}
	
	override func tearDown() {
		QuickDB.shared.resetFactory()
	}
	
	func testExample() {
		if let image = UIImage(named: "Image"), let data = image.pngData(){
			let salam = data.asQuickFile(fileName: "salam")
		}
		
	}
	
}
