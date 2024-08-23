

import Foundation
import CoreData


extension EnergyFillRestoreTimerCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EnergyFillRestoreTimerCoreData> {
        return NSFetchRequest<EnergyFillRestoreTimerCoreData>(entityName: "EnergyFillRestoreTimerCoreData")
    }

    @NSManaged public var energyFillRestoreTimer: Int32

}

extension EnergyFillRestoreTimerCoreData : Identifiable {

}
