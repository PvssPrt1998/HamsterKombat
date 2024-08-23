
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
