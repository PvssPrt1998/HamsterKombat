
import Foundation
import CoreData


extension MiniGameTimerCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MiniGameTimerCoreData> {
        return NSFetchRequest<MiniGameTimerCoreData>(entityName: "MiniGameTimerCoreData")
    }

    @NSManaged public var miniGameTimer: Int32

}

extension MiniGameTimerCoreData : Identifiable {

}
