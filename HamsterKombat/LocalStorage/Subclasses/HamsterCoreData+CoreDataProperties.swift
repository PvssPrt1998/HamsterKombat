//
//  HamsterCoreData+CoreDataProperties.swift
//  HamsterKombat
//
//  Created by Николай Щербаков on 22.08.2024.
//
//

import Foundation
import CoreData


extension HamsterCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HamsterCoreData> {
        return NSFetchRequest<HamsterCoreData>(entityName: "HamsterCoreData")
    }

    @NSManaged public var id: Int32
    @NSManaged public var available: Bool

}

extension HamsterCoreData : Identifiable {

}
