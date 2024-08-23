//
//  SavedDateCoreData+CoreDataProperties.swift
//  HamsterKombat
//
//  Created by Николай Щербаков on 23.08.2024.
//
//

import Foundation
import CoreData


extension SavedDateCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedDateCoreData> {
        return NSFetchRequest<SavedDateCoreData>(entityName: "SavedDateCoreData")
    }

    @NSManaged public var savedDate: String

}

extension SavedDateCoreData : Identifiable {

}
