//
//  GenericModel+CoreDataProperties.swift
//  QuickDB
//
//  Created by Behrad Kazemi on 4/21/20.
//  Copyright © 2020 BEKSAS. All rights reserved.
//

import Foundation
import CoreData
extension GenericModel {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<GenericModel> {
    return NSFetchRequest<GenericModel>(entityName: "GenericModel")
  }

  @NSManaged public var id: UUID
  @NSManaged public var data: Data?
  @NSManaged public var modelName: String
  @NSManaged public var tags: String?
}

