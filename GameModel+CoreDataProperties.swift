import Foundation
import CoreData


extension GameModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameModel> {
        return NSFetchRequest<GameModel>(entityName: "GameModel");
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var rating: Int16
    @NSManaged public var summary: String?
    @NSManaged public var cover: NSData?
    @NSManaged public var internetPage: String?
    @NSManaged public var publishers: PublisherModel?
    @NSManaged public var developers: DeveloperModel?
    @NSManaged public var genres: GenreModel?

}
