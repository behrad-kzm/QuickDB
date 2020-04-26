//
//  QuickData.swift
//  QuickDB
//
//  Created by Behrad Kazemi on 4/26/20.
//

import Foundation
public protocol QuickData: QuickIndexable {
	var uid: UUID { get }
	var fileName: String { get set }
	var pathExtension: String { get set }
	var data: Data? { get }
}


