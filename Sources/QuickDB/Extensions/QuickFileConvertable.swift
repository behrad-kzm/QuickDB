//
//  QuickFileConvertable.swift
//  QuickDB
//
//  Created by Behrad Kazemi on 4/26/20.
//

import Foundation
public protocol QuickFileConvertable {
	func asQuickFile(fileName: String) -> QuickDataFile
}
