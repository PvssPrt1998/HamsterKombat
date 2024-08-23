
import Foundation
import CoreData


extension Parameters {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Parameters> {
        return NSFetchRequest<Parameters>(entityName: "Parameters")
    }

    @NSManaged public var selectedHamsterId: Int32
    @NSManaged public var leagueId: Int32

}

extension Parameters : Identifiable {

}
