//
//  CoreUtils.swift
//  CoreDataManager
//
//  Created by Behrad Kazemi on 3/29/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation

public class Int16s: NSObject, NSCoding {
    
    public var arrayOfInts: [Int16] = []
    
    enum Key:String {
        case Int16s = "Int16s"
    }
    
    init(arrayOfInt: [Int16]) {
        self.arrayOfInts = arrayOfInt
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(arrayOfInts, forKey: Key.Int16s.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mRanges = aDecoder.decodeObject(forKey: Key.Int16s.rawValue) as! [Int16]
        
      self.init(arrayOfInt: mRanges)
    }
    
    
}
public class SJParentValueTransformer<T: NSCoding & NSObject>: ValueTransformer {
     public override class func transformedValueClass() ->
            AnyClass{T.self }
     public override class func allowsReverseTransformation() ->
            Bool { true }
     public override func transformedValue(_ value: Any?) -> Any? {
         guard let value = value as? T else { return nil }
         return try?
             NSKeyedArchiver.archivedData(withRootObject: value,
             requiringSecureCoding: true)
     }
    public override func reverseTransformedValue(_ value: Any?) ->
    Any? {
         guard let data = value as? NSData else { return nil }
         let result = try? NSKeyedUnarchiver.unarchivedObject(
             ofClass: T.self,
             from: data as Data
         )
         return result
    }
       /// The name of this transformer. This is the name used to register the transformer usin "`ValueTransformer.setValueTransformer(_:forName:)"
     public static var transformerName: NSValueTransformerName {
      let className = "\(T.self.classForCoder())"
         return NSValueTransformerName("\(className)Transformer") //we append the Transformer due easily identify.Example. Clase name UserSetting then the name of the transformer is UserSettingTransformer
      }
          
          /// Registers the transformer by calling ValueTransformer.setValueTransformer(_:forName:)`.
     public static func registerTransformer() {
        let transformer = SJParentValueTransformer<T>()
        ValueTransformer.setValueTransformer(transformer, forName:
        transformerName)
     }
}

