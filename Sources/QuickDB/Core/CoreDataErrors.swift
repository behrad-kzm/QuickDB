//
//  CoreDataErrors.swift
//  Pods-QuickDB_Example
//
//  Created by Behrad Kazemi on 4/23/20.
//

import Foundation
public enum CoreDataError: Error {
  case updateError
  case addError
  case deleteError
  case isEmpty
  case getError
  case unknown
}
