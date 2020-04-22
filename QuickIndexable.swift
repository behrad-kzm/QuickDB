//
//  QuickIndexable.swift
//  QuickDB
//
//  Created by Behrad Kazemi on 4/22/20.
//  Copyright © 2020 BEKSAS. All rights reserved.
//

import Foundation
public protocol QuickIndexable: Codable {
	var uid: UUID { get }
}
