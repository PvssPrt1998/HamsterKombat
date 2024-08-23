

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
