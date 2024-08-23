//
//  TapValueCoreData+CoreDataProperties.swift
//  HamsterKombat
//
//  Created by Николай Щербаков on 23.08.2024.
//
//

import Foundation
import CoreData


extension TapValueCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TapValueCoreData> {
        return NSFetchRequest<TapValueCoreData>(entityName: "TapValueCoreData")
    }

    @NSManaged public var tapValue: Int32
    @NSManaged public var tapValueLevel: Int32

}

extension TapValueCoreData : Identifiable {

}
