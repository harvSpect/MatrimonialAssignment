import Foundation
import CoreData

@objc(CachedUser)
public class CachedUser: NSManagedObject {}

extension CachedUser {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var userId: UUID?
    @NSManaged public var value: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var age: Int16
    @NSManaged public var email: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var status: String?
}

extension CachedUser: Identifiable {
    public var id: UUID {
        return userId ?? UUID()
    }
}
