import Foundation
import CoreData


extension Combo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Combo> {
        return NSFetchRequest<Combo>(entityName: "Combo")
    }

    @NSManaged public var first: Int32
    @NSManaged public var second: Int32
    @NSManaged public var third: Int32
    @NSManaged public var thirdGot: Bool
    @NSManaged public var firstGot: Bool
    @NSManaged public var secondGot: Bool
    

}

extension Combo : Identifiable {

}
