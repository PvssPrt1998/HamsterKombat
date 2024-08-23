import Foundation
import CoreData


extension EnergyLevel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EnergyLevel> {
        return NSFetchRequest<EnergyLevel>(entityName: "EnergyLevel")
    }

    @NSManaged public var maxEnergyLevel: Int32
    @NSManaged public var maxEnergy: Int32

}

extension EnergyLevel : Identifiable {

}
