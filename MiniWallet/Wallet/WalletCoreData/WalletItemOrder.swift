import Foundation
import CoreData

@objc(WalletItemOrder)
public class WalletItemOrder: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WalletItemOrder> {
        return NSFetchRequest<WalletItemOrder>(entityName: "WalletItemOrder")
    }

    @NSManaged public var id: String
    @NSManaged public var order: Int32
}
