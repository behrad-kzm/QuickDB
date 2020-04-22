//
//  GenericModel+Decodable.swift
//  QuickDB
//
//  Created by Behrad Kazemi on 4/21/20.
//  Copyright © 2020 BEKSAS. All rights reserved.
//

import Foundation

extension GenericModel {
	func translate<T: Decodable>() -> T? {
		let decoder = JSONDecoder()
		if let safeData = data{
			let decoded = try? decoder.decode(T.self, from: safeData)
			return decoded
		}
		return nil
		
	}
}
