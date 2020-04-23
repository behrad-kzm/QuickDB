//
//  SimpleCodable.swift
//  QuickDB_Example
//
//  Created by Behrad Kazemi on 4/23/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import QuickDB

struct SimpleCodable: QuickIndexable {
	
	let uid = UUID()
	var name: String
	let content: String
}
