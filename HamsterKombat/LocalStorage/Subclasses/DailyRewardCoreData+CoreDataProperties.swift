

import Foundation
import CoreData


extension DailyRewardCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyRewardCoreData> {
        return NSFetchRequest<DailyRewardCoreData>(entityName: "DailyRewardCoreData")
    }

    @NSManaged public var id: Int32
    @NSManaged public var got: Bool

}

extension DailyRewardCoreData : Identifiable {

}
