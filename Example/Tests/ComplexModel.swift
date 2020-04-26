//
//  ComplexModel.swift
//  QuickDB_Example
//
//  Created by Behrad Kazemi on 4/26/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import QuickDB
struct ComplexModel: QuickIndexable {
	let uid = UUID()
	let innerItems: [InnerItem]
}

struct InnerItem: QuickIndexable {
	let leafs: [Leaf]
	let name = "testName"
	let uid = UUID()
	let description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
}

struct Leaf: QuickIndexable {
	let name = "testName"
	let uid = UUID()
	let description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
}
