//
//  ImageModel.swift
//  QuickDB_Example
//
//  Created by Behrad Kazemi on 4/23/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import QuickDB

struct ImageModel: QuickIndexable {
	
	let uid = UUID()
	let name: String
	let data: Data
}
