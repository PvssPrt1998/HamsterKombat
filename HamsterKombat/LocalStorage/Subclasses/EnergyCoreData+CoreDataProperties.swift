
import Foundation
import CoreData


extension EnergyCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EnergyCoreData> {
        return NSFetchRequest<EnergyCoreData>(entityName: "EnergyCoreData")
    }

    @NSManaged public var energy: Int32

}

extension EnergyCoreData : Identifiable {

}
