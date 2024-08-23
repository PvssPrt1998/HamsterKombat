//
//  DayIndex+CoreDataProperties.swift
//  HamsterKombat
//
//  Created by Николай Щербаков on 23.08.2024.
//
//

import Foundation
import CoreData


extension DayIndex {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayIndex> {
        return NSFetchRequest<DayIndex>(entityName: "DayIndex")
    }

    @NSManaged public var dayIndex: Int32

}

extension DayIndex : Identifiable {

}
