import Foundation
import CoreData

@objc(WalletItemCoreData)
public class WalletItemCoreData: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WalletItemCoreData> {
        return NSFetchRequest<WalletItemCoreData>(entityName: "WalletItemCoreData")
    }
    
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var budget: Int32
    @NSManaged public var cost: Int32
    
}
