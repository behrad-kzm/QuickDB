//
//  Data+QuickFileConvertable.swift
//  QuickDB
//
//  Created by Behrad Kazemi on 4/26/20.
//

import Foundation

extension Data: QuickFileConvertable{
	public func asQuickFile(fileName: String) -> QuickDataFile {
		let meme = Swime.mimeType(data: self)		
		return QuickDataFile(fileName: fileName, pathExtension: meme?.ext ?? "data", data: self)
	}
}
