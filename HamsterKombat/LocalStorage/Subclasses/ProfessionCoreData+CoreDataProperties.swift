
import Foundation
import CoreData


extension ProfessionCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfessionCoreData> {
        return NSFetchRequest<ProfessionCoreData>(entityName: "ProfessionCoreData")
    }

    @NSManaged public var id: Int32
    @NSManaged public var totalProfit: Int32
    @NSManaged public var level: Int32
    @NSManaged public var profit: Int32
    @NSManaged public var price: Int32
}

extension ProfessionCoreData : Identifiable {

}
